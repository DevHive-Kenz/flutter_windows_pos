// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenz/constants/color_manger.dart';
import 'package:kenz/constants/constants.dart';
import 'package:kenz/constants/style_manager.dart';
import 'package:kenz/core/interceptor/retry_interceptor.dart';
import '../../constants/api_const/api_const.dart';
import '../../main.dart';
import 'auth_interceptor.dart';
import 'connectivity_retry_interceptor.dart';

class Api {
  final dio = createDio();

  // final tokenDio = Dio(BaseOptions(baseUrl: AppAPI.BaseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio();
    dio.options.baseUrl = AppAPI.baseUrl;
    dio.interceptors
    ..add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: true))
      ..add(AuthInterceptor(dio))
      ..add(AppInterceptors(dio))
      ..add(
        RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
              dio: dio, connectivity: Connectivity()),
        ),
      );
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.badResponse) {
      switch (err.response?.statusCode) {
        case 400:
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return           showAwesomeDialogue(content: "Please Try Again Later (400)",title: "Warning");

            },
          );
          break;
        case 401:
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return           showAwesomeDialogue(content: "Please Try Again Later (401)",title: "Warning");

            },
          );
        break;
        case 404:
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return           showAwesomeDialogue(content: "Please Try Again Later (404)",title: "Warning");

            },
          );
        break;
        case 409:
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return           showAwesomeDialogue(content: "Please Try Again Later (409)",title: "Warning");

            },
          );
        break;
        case 500:
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return           showAwesomeDialogue(content: "Please Try Again Later (500)",title: "Warning");

            },
          );
        break;
        case 502:
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return           showAwesomeDialogue(content: "Please Try Again Later (502)",title: "Warning");

            },
          );
        break;
        default:
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return           showAwesomeDialogue(content: "Please Try Again Later ${err.response?.data["message"]}",title: "Warning");

            },
          );       break;
      }
    } else if (err.type == DioExceptionType.unknown) {
       SnackBar snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("No Internet Connection",style: getSemiBoldStyle(color: ColorManager.white),),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
    handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
   }
}