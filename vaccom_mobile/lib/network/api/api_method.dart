part of api;

extension ApiMethod on API {

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// GET
  static Future<BaseResponse> getData(
      NetworkItem api,
      Map<String, dynamic> params) async {

    final isOnline = await hasNetwork();
    if (isOnline == false) {
      throw NetworkException();
    }

    logger.info('\n[${api.name}] GET ${api.path} - params: $params');

    var accessToken = await Utils.getAppToken();

    Map<String, String> headers = {};
    if (accessToken.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }

    final uri = Uri.https(Global.shared.authority, api.path, params);

    try {
      var response = await http.get(uri, headers: headers);
      var base = _processResponse(response);

      if (base.isSuccess) {
        return base;
      } else {
        throw ServerException(base.message);
      }
    } catch (e) {
      throw e;
    }
  }

  /// POST
  static Future<BaseResponse> postData(
      NetworkItem api, Map<String, dynamic> params) async {

    final isOnline = await hasNetwork();
    if (isOnline == false) {
      throw NetworkException();
    }

    logger.info('\n[${api.name}] POST ${api.path} - params: $params');

    var accessToken = await Utils.getAppToken();

    Map<String, String> headers = {};
    if (accessToken.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }

    final uri = Uri.https(Global.shared.authority, api.path);

    try {
      var response = await http.post(
        uri,
        body: params,
        headers: headers,
      );
      var base = _processResponse(response);

      if (base.isSuccess) {
        return base;
      } else {
        throw ServerException(base.message);
      }
    } catch (e) {
      throw e;
    }
  }

  ///
  static BaseResponse _processResponse(http.Response response) {
    try {
      var responseJson = json.decode(response.body.toString());
      logger.info(response.request.url.toString());

      logger.info(responseJson);
      var base = BaseResponse.fromJson(responseJson);
      logger.info(base.debug);

      return base;
    } catch (e) {
      throw ParsingError();
    }
  }
}
