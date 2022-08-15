package com.pravera.flutter_bpass_lib.utils

import com.pravera.flutter_bpass_lib.errors.ErrorCodes
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class ErrorHandleUtils {
	companion object {
		fun handleMethodCallError(result: MethodChannel.Result?, errorCode: ErrorCodes) {
			result?.error(errorCode.toString(), errorCode.message(), null)
		}

		fun handleStreamError(events: EventChannel.EventSink?, errorCode: ErrorCodes) {
			events?.error(errorCode.toString(), errorCode.message(), null)
		}
	}
}
