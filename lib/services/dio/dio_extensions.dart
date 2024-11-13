import 'package:dio/dio.dart';

extension IsOk on Response {
  bool get ok {
    return ((statusCode ?? -1) ~/ 100) == 2;
  }
}
