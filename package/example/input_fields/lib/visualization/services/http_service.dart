import 'dart:convert';
import 'dart:io';
import 'package:dhis2_flutter_ui/dhis2_flutter_ui.dart';
import 'package:dio/dio.dart';
import 'dio_service.dart';



class CustomHttpService extends HttpService {
  final String username;
  final String password;
  final String baseUrl;
  Dio? _dio = dioInstance;

  CustomHttpService(
      {required this.username, required this.password, required this.baseUrl}) {
    String username = this.username;
    String password = this.password;
    basicAuth = base64Encode(utf8.encode('$username:$password'));
  }

  get dio async {
    if (_dio == null) {
      _dio = await initDio();
      return _dio;
    }
    return _dio;
  }

  Uri sanitizeUrl(Uri url) {
    String urlToParse = Uri.decodeFull(url.toString());
    return Uri.parse(urlToParse);
  }

  String get domainPath {
    return baseUrl
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .split('/')
        .where((domain) => domain != domainHost && domain.isNotEmpty)
        .toList()
        .join('/');
  }

  String get domainHost {
    return baseUrl
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .split('/')
        .first;
  }

  Uri getApiUrl(String url, {Map<String, dynamic>? queryParameters}) {
    url = domainPath == '' ? url : '$domainPath/$url';
    return Uri.https(domainHost, url, queryParameters);
  }

  Future<Response> httpPost(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    Dio dio = await this.dio;
    return dio.postUri(
      apiUrl,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: 'Basic $basicAuth',
        'Content-Type': 'application/json',
      }),
      data: body,
    );
  }

  Future<Response> httpPut(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    Dio dio = await this.dio;
    return dio.putUri(apiUrl,
        data: body,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $basicAuth',
          'Content-Type': 'application/json',
        }));
  }

  Future<Response> httpDelete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    Dio dio = await this.dio;
    return await dio.deleteUri(apiUrl,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $basicAuth',
        }));
  }

  Future<Response> httpGet(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    apiUrl = sanitizeUrl(apiUrl);
    Dio dio = await this.dio;
    return await dio.getUri(apiUrl,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $basicAuth',
        }));
  }

  Future<Response> httpGetPagination(
    String url,
    Map<String, dynamic> queryParameters,
  ) async {
    Map<String, dynamic> dataQueryParameters = {
      'totalPages': 'true',
      'pageSize': '1',
      'fields': 'none',
    };
    dataQueryParameters.addAll(queryParameters);
    return await httpGet(url, queryParameters: dataQueryParameters);
  }

  @override
  String toString() {
    return '$basicAuth';
  }

  @override
  Map<String, dynamic> getDataFromResponse(dynamic response) {
    if (response.statusCode == 200 || response.statusCode == 304) {
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
