package com.pravera.flutter_bpass_lib.service

import com.pravera.flutter_bpass_lib.errors.ErrorCodes
import com.pravera.flutter_bpass_lib.models.RequestResult

interface BpassSdkCallback {
    fun onAuthSuccess(reqResult: RequestResult)
    fun onAuthFailure(errorCode: ErrorCodes)
}
