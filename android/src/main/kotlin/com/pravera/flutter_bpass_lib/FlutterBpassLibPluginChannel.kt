package com.pravera.flutter_bpass_lib

import android.app.Activity
import io.flutter.plugin.common.BinaryMessenger

interface FlutterBpassLibPluginChannel {
    fun init(messenger: BinaryMessenger)
    fun setActivity(activity: Activity?)
    fun dispose()
}
