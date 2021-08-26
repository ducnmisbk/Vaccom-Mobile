import 'package:vaccom_mobile/network/api/api.dart';

class MockAPI implements API {
  MockAPI._();

  static final shared = MockAPI._();

  @override
  ApiType apiType = ApiType.mock;
}