import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mystoryhub/data/exception/app_exceptions.dart';
import 'package:mystoryhub/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final dynamic response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw  SocketException('No Internet Connection',);
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final dynamic response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }  on SocketException {
      throw  SocketException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 503:
      case 404:
        throw UnAuthorizedException(response.body.toString());
      default:
        throw SocketException('Error while communicating with server with error code: ${response.statusCode}');
    }
  }
}
