package com.pravera.flutter_bpass_lib

import androidx.annotation.NonNull
import com.pravera.flutter_bpass_lib.service.BpassSdkManager
import com.pravera.flutter_bpass_lib.service.ServiceProvider

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterBpassLibPlugin */
class FlutterBpassLibPlugin: FlutterPlugin, ActivityAware, ServiceProvider {
  private var activityBinding: ActivityPluginBinding? = null
  private lateinit var methodCallHandler: MethodCallHandlerImpl

  private val bpassSdkManager = BpassSdkManager()

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    methodCallHandler = MethodCallHandlerImpl(binding.applicationContext, this)
    methodCallHandler.init(binding.binaryMessenger)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    if (::methodCallHandler.isInitialized) {
      methodCallHandler.dispose()
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    methodCallHandler.setActivity(binding.activity)

    binding.addActivityResultListener(bpassSdkManager)
    activityBinding = binding
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    methodCallHandler.setActivity(null)

    activityBinding?.removeActivityResultListener(bpassSdkManager)
    activityBinding = null
  }

  override fun getBpassSdkManager() = bpassSdkManager
}
