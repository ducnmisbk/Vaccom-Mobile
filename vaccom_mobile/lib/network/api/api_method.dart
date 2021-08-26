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

  static String convertMapToQueryParameter(Map<String, dynamic> params) {
    var result = List<String>();
    params.forEach((key, value) {
      result.add("$key=$value");
    });
    return result.join('&');
  }

  /// GET
  static Future<dynamic> getData(
      ApiPath api, Map<String, dynamic> params) async {
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

    String endpoint = Global.shared.endpoint(api.path);
    if (params.isNotEmpty) {
      String queryString = ApiMethod.convertMapToQueryParameter(params);
      endpoint += '?$queryString';
    }

    try {
      var response = await http.get(endpoint, headers: headers);
      var jsonData = _processResponse(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  /// POST
  static Future<dynamic> postData(
      ApiPath api, Map<String, dynamic> params) async {
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
      var jsonData = _processResponse(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  /// TOKEN
  static Future<dynamic> getToken({String username, String password}) async {
    final isOnline = await hasNetwork();
    if (isOnline == false) {
      throw NetworkException();
    }

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    logger.info(basicAuth);

    try {
      var response = await http.post(
        Global.shared.endpoint(ApiPath.login.path),
        headers: {'authorization': basicAuth},
      );

      var responseJson = json.decode(response.body);
      logger.info(responseJson);
      return responseJson;
    } catch (e) {
      throw e;
    }
  }

  ///
  static dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        logger.info(responseJson);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(response.body);
      case 401:

      /// Handle Refresh token here

      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException('Lỗi kết nối: ${response.statusCode}');
    }
  }
}
