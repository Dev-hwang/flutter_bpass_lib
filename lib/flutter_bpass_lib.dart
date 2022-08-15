export 'package:flutter_bpass_lib/models/request_data.dart';
export 'package:flutter_bpass_lib/models/request_result.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bpass_lib/models/request_data.dart';
import 'package:flutter_bpass_lib/models/request_result.dart';
import 'package:uuid/uuid.dart';

class FlutterBpassLib {
  static const _mChannel = MethodChannel('flutter_bpass_lib/method');

  static Future<RequestResult> requestSign({required RequestData data}) async {
    final resultJson =
        await _mChannel.invokeMethod('requestSign', data.toJson());
    return RequestResult.fromJson(jsonDecode(resultJson));
  }

  static String generateV1UUID() => const Uuid().v1();

  static String generateV4UUID() => const Uuid().v4();
}
