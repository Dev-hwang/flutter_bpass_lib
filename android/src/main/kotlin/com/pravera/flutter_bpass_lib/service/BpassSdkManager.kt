package com.pravera.flutter_bpass_lib.service

import android.app.Activity
import android.content.Intent
import com.coinplug.bpass.sdk.BPassSDK
import com.coinplug.bpass.sdk.ResultHandler
import com.pravera.flutter_bpass_lib.errors.ErrorCodes
import com.pravera.flutter_bpass_lib.models.RequestData
import com.pravera.flutter_bpass_lib.models.RequestResult
import io.flutter.plugin.common.PluginRegistry

class BpassSdkManager: PluginRegistry.ActivityResultListener, ResultHandler {
    private var bpassSdk: BPassSDK? = null
    private var activity: Activity? = null
    private var callback: BpassSdkCallback? = null

    fun requestSign(
        activity: Activity,
        requestData: RequestData,
        callback: BpassSdkCallback
    ) {
        this.bpassSdk = BPassSDK(activity, this)
        this.activity = activity
        this.callback = callback

        val state = requestData.state
        val type = requestData.type
        val dataHash = requestData.dataHash
        val did = requestData.did

        if (dataHash == null && did == null) {
            bpassSdk?.requestSign(state, type)
        } else if (dataHash != null && did == null) {
            bpassSdk?.requestSign(state, type, dataHash)
        } else {
            bpassSdk?.requestSign(state, type, dataHash, did)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (bpassSdk?.handleResult(requestCode, resultCode, data) == true) {
            return true
        }

        return false
    }

    override fun onNotInstall(intent: Intent?) {
        activity?.startActivity(intent)
        callback?.onAuthFailure(ErrorCodes.APP_NOT_INSTALL)
    }

    override fun onAuthInitFailed(statusCode: Int, errorCode: Int, message: String?) {
        callback?.onAuthFailure(ErrorCodes.AUTH_INIT_FAILED)
    }

    override fun onResult(resultCode: Int, state: String?, type: Int, code: String?) {
        if (resultCode == Activity.RESULT_OK) {
            val result = RequestResult(state = state, type = type, code = code)
            callback?.onAuthSuccess(result)
        } else {
            when (resultCode) {
                0 -> callback?.onAuthFailure(ErrorCodes.AUTH_FAILED)
                1 -> callback?.onAuthFailure(ErrorCodes.NOT_CREATED_META_DID)
                2 -> callback?.onAuthFailure(ErrorCodes.NOT_MATCHED_META_DID)
                3 -> callback?.onAuthFailure(ErrorCodes.MISSING_SERVICE_ID)
                4 -> callback?.onAuthFailure(ErrorCodes.INVALID_PARAMETER)
                5 -> callback?.onAuthFailure(ErrorCodes.EXPIRED_AUTH_TIME)
                6 -> callback?.onAuthFailure(ErrorCodes.NETWORK_ERROR)
            }
        }
    }
}
