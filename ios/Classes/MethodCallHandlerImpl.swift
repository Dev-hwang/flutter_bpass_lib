//
//  MethodCallHandlerImpl.swift
//  flutter_bpass_lib
//
//  Created by 김형도 on 2022/04/20.
//

import Flutter
import Foundation
import BusanKeepinSDK

class MethodCallHandlerImpl: NSObject {
  private let channel: FlutterMethodChannel
  private var sdk: BusanKeepinSDK? = nil
  
  init(messenger: FlutterBinaryMessenger) {
    self.channel = FlutterMethodChannel(name: "flutter_bpass_lib/method", binaryMessenger: messenger)
    super.init()
    self.channel.setMethodCallHandler(onMethodCall)
  }
  
  func onMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "requestSign":
        let argsDict = call.arguments as? Dictionary<String, Any>
        let requestData = RequestData(from: argsDict)
        
        let handler = MyBusanKeepinSDKHandler(requestData: requestData, result: result)
        
        do {
          sdk = try BusanKeepinSDK(handler: handler)
          try sdk!.requestSign(state: requestData.state, type: requestData.type, dataHash: nil, did: nil)
        } catch BusanKeepinSDKError.serviceIDNotFound {
          ErrorHandleUtils.handleMethodCallError(result: result, errorCode: ErrorCodes.MISSING_SERVICE_ID)
        } catch BusanKeepinSDKError.stateInvalid {
          ErrorHandleUtils.handleMethodCallError(result: result, errorCode: ErrorCodes.INVALID_PARAMETER)
        } catch BusanKeepinSDKError.dataHashInvalid {
          ErrorHandleUtils.handleMethodCallError(result: result, errorCode: ErrorCodes.INVALID_PARAMETER)
        } catch {
          ErrorHandleUtils.handleMethodCallError(result: result, errorCode: ErrorCodes.UNKNOWN_ERROR)
        }
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
