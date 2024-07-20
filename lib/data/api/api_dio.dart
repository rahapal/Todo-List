import 'package:dio/dio.dart';
import 'package:todo_list/data/data.dart';

class ApiDio {
  ApiDio._();

  static ApiDio? _apiDio;

  final Dio dio = Dio()..interceptors.add(ApiInterceptors());

  static ApiDio get instance {
    _apiDio ??= ApiDio._();
    return _apiDio!;
  }
}
