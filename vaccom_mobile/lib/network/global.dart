class Global {
  static const _host = 'http://dev.chothuetatca.com';
  static const _version = 'api/v1.0';

  Global._();

  static final shared = Global._();

  String get authority => _host + _version;

  String deviceToken = '';
}