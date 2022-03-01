import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://aroma.apex.ps/api',
        // headers: {
        //   'Content-Type': 'application/json',
        // },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'accept': 'application/json',
      'accept-language': lang,
      'Authorization': token ?? '',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'ar',
    String token,
  }) async {
    dio.options.headers = {
      'accept': 'application/json',
      'accept-language': lang,
      'Authorization': token ?? '',
    };
    return dio.post(
      url,
      queryParameters: query ?? null,
      data: data,
    );
  }

  static Future<Response> postOrder({
    @required String url,
    @required FormData data,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'accept': 'application/json',
      'accept-language': lang,
      'Authorization': token ?? '',
    };
    return dio.post(
      url,
      queryParameters: query ?? null,
      data: data,
    );
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'accept': 'application/json',
      'accept-language': lang,
      'Authorization': token ?? '',
    };
    return dio.put(
      url,
      queryParameters: query ?? null,
      data: data,
    );
  }
}
// 'accept-language': lang,
// 'Content-Type': 'multipart/form-data; boundary=--------------------------998399702663954843309164',
// 'Content-Length': '174',
// 'Host': 'aroma.apex.ps"',
// 'User-Agent': 'PostmanRuntime/7.29.0',
// 'Accept': '*/*',
// 'Accept-Encoding': 'gzip',
// 'Connection': 'keep-Alive',
// 'postman-token': 'e65d7ff2-8bb9-41d4-ab3e-354da2d29d24',