class NetworkException implements Exception {
  final String? code;
  final String? endpoint;
  final String? error;

  const NetworkException({this.endpoint, this.code, this.error});

  @override
  String toString() => 'В запросе $endpoint возникла ошибка $code $error';
}
