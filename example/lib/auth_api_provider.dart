import 'package:flutter_dev_framework/network/model/http_request_method.dart';
import 'package:flutter_dev_framework/network/rest_api.dart';

const String kTestApiAuthority = '';
const String kAuthApiAuthority = '';
const String kGetStateUri = '';
const String kSignInUri = '';

class AuthApiProvider extends RestApi {
  AuthApiProvider._internal();
  static final instance = AuthApiProvider._internal();

  /// B-Pass 인증에 필요한 state 값을 가져온다.
  Future<String> getState({required String uuid}) async {
    final response = await rest(
      reqMethod: HttpRequestMethod.POST,
      path: kGetStateUri,
      body: {
        'type': 1,
      }
    );

    print(response);
    final state = response['data']['state'];
    if (state == null) {
      final error = response['data']['error'] ?? '';
      throw Exception(error);
    }

    return state;
  }

  /// B-Pass 인증 결과 코드를 검증하여 로그인을 수행한다.
  Future<String> signIn({
    required String uuid,
    required int type,
    required String code,
    required String state,
  }) async {
    final response = await rest(
      reqMethod: HttpRequestMethod.POST,
      path: kSignInUri,
      body: {
        'uuid': uuid,
        'type': type,
        'code': code,
        'state': state,
      }
    );

    return response.toString();
  }
}
