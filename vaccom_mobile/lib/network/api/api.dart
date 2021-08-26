library api;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vaccom_mobile/commons/utils.dart';
import 'package:vaccom_mobile/network/exception.dart';
import 'package:vaccom_mobile/network/global.dart';
import 'package:vaccom_mobile/network/response/base.dart';

part 'api_method.dart';

enum ApiType { mock, remote }

abstract class API {
  ApiType apiType;
}

class NetworkItem {
  String name, path;

  NetworkItem({this.name, this.path});

}