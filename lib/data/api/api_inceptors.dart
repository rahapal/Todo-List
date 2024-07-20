import 'package:dio/dio.dart';
import 'package:todo_list/data/data.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var hasInternet = await ConnectivityUtils.instance.hasInternet;
    if (!hasInternet) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          response: Response(
            requestOptions: options,
            data: {
              "title": "Whoops!",
              "message":
                  "No Internet connection found. Check your connection or try again.",
            },
          ),
        ),
      );
    }
    super.onRequest(options, handler);
  }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   if (err.response != null && err.response!.statusCode == 403) {
  //     BotToast.showLoading();
  //     FirebaseAuth.instance.signOut().then((value) async {
  //       BotToast.closeAllLoading();
  //       await SecureStorage.deleteData(SharedConstants.bearear);
  //       BotToast.showText(text: "Session Expired");
  //       navigatorKey.currentContext?.push(SplashScreen.routeName);
  //     });
  //   }
  //   return super.onError(err, handler);
  // }
}
