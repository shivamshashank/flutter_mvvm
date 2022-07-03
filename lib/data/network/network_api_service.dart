import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm/data/app_exception.dart';
import 'package:flutter_mvvm/data/network/base_api_service.dart';
import 'package:flutter_mvvm/res/urls.dart';
import 'package:http/http.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getApiResponse(
    String endpoint,
  ) async {
    dynamic responseJson;

    try {
      Response response = await get(
        Uri.parse("${Urls.baseUrl}/$endpoint"),
      ).timeout(
        const Duration(seconds: 10),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      throw UnknownException("An Unknown Error Occurred");
    }

    return responseJson;
  }

  @override
  Future postApiResponse(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    dynamic responseJson;

    try {
      Response response = await post(
        Uri.parse("${Urls.baseUrl}/$endpoint"),
        body: body,
      ).timeout(
        const Duration(seconds: 10),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      throw UnknownException("An Unknown Error Occurred");
    }

    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException("Status Code : ${response.statusCode}");
    }
  }
}
