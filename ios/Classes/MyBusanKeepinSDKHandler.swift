//
//  MyBusanKeepinSDKHandler.swift
//  flutter_bpass_lib
//
//  Created by WOO JIN HWANG on 2022/05/04.
//

import Flutter
import Foundation
import BusanKeepinSDK

class MyBusanKeepinSDKHandler: BusanKeepinResultHandler {
  private let jsonEncoder: JSONEncoder
  private let requestData: RequestData
  private let result: FlutterResult

  init(requestData: RequestData, result: @escaping FlutterResult) {
    self.jsonEncoder = JSONEncoder()
    self.requestData = requestData
    self.result = result
  }

  func onNotInstall(url: URL) {
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
    handleError(errorCode: ErrorCodes.APP_NOT_INSTALL)
  }

  func onAuthInitError(statusCode: Int, errorCode: Int, errorMessage: String) {
    // print("statusCode: \(statusCode), errorCode: \(errorCode), errorMessage: \(errorMessage)")
    handleError(errorCode: ErrorCodes.AUTH_INIT_FAILED)
  }

  func onResult(code: String, resultCode: Int) {
    if resultCode == -1 {
      do {
        let requestResult = RequestResult(state: requestData.state, type: requestData.type, code: code)
        let requestResultJson = try jsonEncoder.encode(requestResult)
        result(String(data: requestResultJson, encoding: .utf8))
      } catch {
        handleError(errorCode: ErrorCodes.UNKNOWN_ERROR)
      }
    } else {
      switch resultCode {
        case 0:
          handleError(errorCode: ErrorCodes.AUTH_FAILED)
        case 1:
          handleError(errorCode: ErrorCodes.NOT_CREATED_META_DID)
        case 2:
          handleError(errorCode: ErrorCodes.NOT_MATCHED_META_DID)
        case 3:
          handleError(errorCode: ErrorCodes.MISSING_SERVICE_ID)
        case 4:
          handleError(errorCode: ErrorCodes.INVALID_PARAMETER)
        case 5:
          handleError(errorCode: ErrorCodes.EXPIRED_AUTH_TIME)
        case 6:
          handleError(errorCode: ErrorCodes.NETWORK_ERROR)
        default:
          handleError(errorCode: ErrorCodes.UNKNOWN_ERROR)
      }
    }
  }

  func handleError(errorCode: ErrorCodes) {
    ErrorHandleUtils.handleMethodCallError(result: result, errorCode: errorCode)
  }
}
