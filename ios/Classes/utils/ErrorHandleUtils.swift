//
//  ErrorHandleUtils.swift
//  flutter_bpass_lib
//
//  Created by WOO JIN HWANG on 2022/05/04.
//

import Flutter
import Foundation

class ErrorHandleUtils {
  static func handleMethodCallError(result: FlutterResult, errorCode: ErrorCodes) {
    let error = FlutterError(code: errorCode.rawValue, message: errorCode.message(), details: nil)
    result(error)
  }
  
  static func handleStreamError(events: FlutterEventSink, errorCode: ErrorCodes) {
    let error = FlutterError(code: errorCode.rawValue, message: errorCode.message(), details: nil)
    events(error)
  }
}
