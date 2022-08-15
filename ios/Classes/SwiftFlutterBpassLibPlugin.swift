import Flutter
import UIKit

public class SwiftFlutterBpassLibPlugin: NSObject, FlutterPlugin {
  private var methodCallHandler: MethodCallHandlerImpl? = nil
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SwiftFlutterBpassLibPlugin()
    instance.initChannels(registrar.messenger())
  }
  
  private func initChannels(_ messenger: FlutterBinaryMessenger) {
    methodCallHandler = MethodCallHandlerImpl(messenger: messenger)
  }
}
