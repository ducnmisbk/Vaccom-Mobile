import 'package:vaccom_mobile/network/api/api.dart';

class RemoteAPI implements API {
  RemoteAPI._();

  static final shared = RemoteAPI._();

  @override
  ApiType apiType = ApiType.remote;
}