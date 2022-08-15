import 'package:flutter/material.dart';
import 'package:flutter_bpass_lib/flutter_bpass_lib.dart';
import 'package:flutter_bpass_lib_example/auth_api_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _requestStatusNotifier = ValueNotifier<bool>(false);
  final _requestResultNotifier = ValueNotifier<String?>(null);

  void _onAuthRequestButtonPressed() async {
    if (_requestStatusNotifier.value) return;

    _requestStatusNotifier.value = true;

    try {
      final nUUID = FlutterBpassLib.generateV4UUID();
      final state = await AuthApiProvider.instance.getState(uuid: nUUID);

      const type = 1;
      final data = RequestData(state: state, type: type);
      final signResult = await FlutterBpassLib.requestSign(data: data);
      print('signResult: ${signResult.toJson()}');

      final code = signResult.code;
      if (code == null) {
        throw Exception('인증 결과 코드가 누락되었습니다.');
      }

      final requestResult = await AuthApiProvider.instance.signIn(
        uuid: nUUID,
        type: type,
        code: code,
        state: state,
      );

      _requestResultNotifier.value = requestResult;
    } catch (e, s) {
      print('onAuthRequestButtonPressed() - error: $e, stackTrace: $s');
    } finally {
      _requestStatusNotifier.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    AuthApiProvider.instance.initialize(authority: kAuthApiAuthority);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_bpass_lib'),
        ),
        body: buildContentView(),
      ),
    );
  }

  Widget buildContentView() {
    final requestResultWidget = ValueListenableBuilder<String?>(
      valueListenable: _requestResultNotifier,
      builder: (_, value, __) {
        return Center(child: Text(value.toString()));
      },
    );

    final requestButton = ValueListenableBuilder<bool>(
      valueListenable: _requestStatusNotifier,
      builder: (_, value, __) {
        return SizedBox(
          height: 52.0,
          child: ElevatedButton(
            child: value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('인증 요청하기'),
            onPressed: _onAuthRequestButtonPressed,
          ),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: requestResultWidget),
        requestButton,
      ],
    );
  }
}
