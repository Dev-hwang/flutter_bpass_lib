//
//  ErrorCodes.swift
//  flutter_bpass_lib
//
//  Created by WOO JIN HWANG on 2022/05/04.
//

import Foundation

enum ErrorCodes: String {
  case APP_NOT_INSTALL
  case AUTH_INIT_FAILED
  case AUTH_FAILED
  case NOT_CREATED_META_DID
  case NOT_MATCHED_META_DID
  case MISSING_SERVICE_ID
  case INVALID_PARAMETER
  case EXPIRED_AUTH_TIME
  case NETWORK_ERROR
  case UNKNOWN_ERROR
  
  func message() -> String {
    switch self {
      case .APP_NOT_INSTALL:
        return "B-PASS 앱이 설치되어 있지 않습니다."
      case .AUTH_INIT_FAILED:
        return "인증 서비스 초기화에 실패하였습니다."
      case .AUTH_FAILED:
        return "인증을 취소하였거나 실패하였습니다."
      case .NOT_CREATED_META_DID:
        return "META DID가 생성되어 있지 않습니다."
      case .NOT_MATCHED_META_DID:
        return "요청 시의 DID와 B-PASS 앱의 DID가 일치하지 않습니다."
      case .MISSING_SERVICE_ID:
        return "service_id 값이 없습니다."
      case .INVALID_PARAMETER:
        return "필수 값이 없거나 올바르지 않은 파라미터 입니다."
      case .EXPIRED_AUTH_TIME:
        return "인증 시간이 만료되었습니다."
      case .NETWORK_ERROR:
        return "네트워크 오류가 발생하였습니다."
      case .UNKNOWN_ERROR:
        return "알 수 없는 오류가 발생하였습니다."
    }
  }
}
