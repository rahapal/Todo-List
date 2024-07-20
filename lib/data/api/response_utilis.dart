import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/presentation/presentation.dart';

class ResponseUtils {
  ResponseUtils._();
  static ResponseUtils? _utils;

  static ResponseUtils get instance {
    _utils ??= ResponseUtils._();
    return _utils!;
  }

  ApiResponse parseResponse(DioException e) {
    late ApiResponse response;
    try {
      if (e.response?.data != null) {
        log("\x1B[31m Responseeeeee \x1B[0m");
        log("\x1B[31m ${e.response?.data} \x1B[0m");

        response = ApiResponse(
          status: false,
          message: e.response!.data["message"],
          title: e.response!.data["title"],
        );
      } else {
        response = switch (e.type) {
          DioExceptionType.connectionError => ApiResponse(
              status: false,
              title: "Whoops!",
              message:
                  "Failed to resolve request. Check your internet and try again.",
            ),
          DioExceptionType.connectionTimeout => ApiResponse(
              status: false,
              title: "Whoops!",
              message:
                  "Internet connection timed out. Check your internet and try again.",
            ),
          _ => ApiResponse(
              status: false,
              title: "Error",
              message: "Something went wrong",
            ),
        };
      }
    } catch (e) {
      response = ApiResponse(
        status: false,
        title: "Error",
        message: "Something went wrong",
      );
    }
    if (response.message
        .toLowerCase()
        .startsWith("No Internet".toLowerCase())) {
      CustomBotToast.showErrorDialog(
        title: response.title,
        message: response.message,
      );
    }
    return response;
  }
}
