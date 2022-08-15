class RequestData {
  const RequestData({
    this.state,
    required this.type,
    this.dataHash,
    this.did,
  });

  final String? state;

  final int type;

  final String? dataHash;

  final String? did;

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'type': type,
      'dataHash': dataHash,
      'did': did,
    };
  }
}
