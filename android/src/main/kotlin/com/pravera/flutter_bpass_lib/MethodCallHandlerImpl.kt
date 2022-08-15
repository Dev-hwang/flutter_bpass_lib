package com.pravera.flutter_bpass_lib

import android.app.Activity
import android.content.Context
import com.google.gson.Gson
import com.pravera.flutter_bpass_lib.errors.ErrorCodes
import com.pravera.flutter_bpass_lib.models.RequestData
import com.pravera.flutter_bpass_lib.models.RequestResult
import com.pravera.flutter_bpass_lib.service.BpassSdkCallback
import com.pravera.flutter_bpass_lib.service.ServiceProvider
import com.pravera.flutter_bpass_lib.utils.ErrorHandleUtils

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

class MethodCallHandlerImpl(
	private val context: Context,
	private val serviceProvider: ServiceProvider
	) : MethodChannel.MethodCallHandler, FlutterBpassLibPluginChannel {

	private lateinit var channel: MethodChannel
	private var activity: Activity? = null

	override fun onMethodCall(call: MethodCall, result: Result) {
		if (activity == null) {
			ErrorHandleUtils.handleMethodCallError(result, ErrorCodes.ACTIVITY_NOT_ATTACHED)
			return
		}

		val argsMap = call.arguments as? Map<*, *>

		when (call.method) {
			"requestSign" -> {
				val requestData = RequestData.fromMap(argsMap)
				serviceProvider.getBpassSdkManager().requestSign(
					activity = activity!!,
					requestData = requestData,
					callback = object : BpassSdkCallback {
						override fun onAuthSuccess(reqResult: RequestResult) {
							val resultJson = Gson().toJson(reqResult)
							result.success(resultJson)
						}

						override fun onAuthFailure(errorCode: ErrorCodes) {
							ErrorHandleUtils.handleMethodCallError(result, errorCode)
						}
					}
				)
			}
			else -> result.notImplemented()
		}
	}

	override fun init(messenger: BinaryMessenger) {
		channel = MethodChannel(messenger, "flutter_bpass_lib/method")
		channel.setMethodCallHandler(this)
	}

	override fun setActivity(activity: Activity?) {
		this.activity = activity
	}

	override fun dispose() {
		if (::channel.isInitialized) {
			channel.setMethodCallHandler(null)
		}
	}
}
