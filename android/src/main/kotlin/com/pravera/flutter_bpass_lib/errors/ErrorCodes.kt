package com.pravera.flutter_bpass_lib.errors

enum class ErrorCodes {
	ACTIVITY_NOT_ATTACHED,
	APP_NOT_INSTALL,
	AUTH_INIT_FAILED,
	AUTH_FAILED,
	NOT_CREATED_META_DID,
	NOT_MATCHED_META_DID,
	MISSING_SERVICE_ID,
	INVALID_PARAMETER,
	EXPIRED_AUTH_TIME,
	NETWORK_ERROR,
	UNKNOWN_ERROR;

	fun message(): String {
		return when (this) {
			ACTIVITY_NOT_ATTACHED -> "Flutter 엔진에 연결되어 있는 Activity가 없습니다."
			APP_NOT_INSTALL -> "B-Pass 앱이 설치되어 있지 않습니다."
			AUTH_INIT_FAILED -> "인증 서비스 초기화에 실패하였습니다."
			AUTH_FAILED -> "인증을 취소하였거나 실패하였습니다."
			NOT_CREATED_META_DID -> "META DID가 생성되어 있지 않습니다."
			NOT_MATCHED_META_DID -> "요청 시의 DID와 BPASS 앱의 DID가 일치하지 않습니다."
			MISSING_SERVICE_ID -> "service_id 값이 없습니다."
			INVALID_PARAMETER -> "필수 값이 없거나 올바르지 않은 파라미터 입니다."
			EXPIRED_AUTH_TIME -> "인증 시간이 만료되었습니다."
			NETWORK_ERROR -> "네트워크 오류가 발생하였습니다."
			UNKNOWN_ERROR -> "알 수 없는 오류가 발생하였습니다."
		}
	}
}
