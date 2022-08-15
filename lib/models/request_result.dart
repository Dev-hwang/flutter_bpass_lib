class RequestResult {
  const RequestResult({
    this.state,
    required this.type,
    this.code,
  });

  final String? state;

  final int type;

  final String? code;

  factory RequestResult.fromJson(Map<String, dynamic> json) {
    final state = json['state'];
    final type = json['type'];
    final code = json['code'];

    return RequestResult(
      state: state,
      type: type,
      code: code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'type': type,
      'code': code,
    };
  }
}
