import 'dart:async';
import 'dart:convert';
import 'dart:io';

abstract class HttpService {
  String? basicAuth;

  Uri sanitizeUrl(Uri url) {
    String urlToParse = Uri.decodeFull(url.toString());
    return Uri.parse(urlToParse);
  }

  String get domainPath;

  String get domainHost;

  Uri getApiUrl(String url, {Map<String, dynamic>? queryParameters}) {
    url = domainPath == '' ? url : '$domainPath/$url';
    return Uri.https(domainHost, url, queryParameters);
  }

  Future<dynamic> httpPost(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> httpPut(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  });

  Map<String, dynamic> getDataFromResponse(dynamic response);

  Future<dynamic> httpDelete(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> httpGet(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> httpGetPagination(
    String url,
    Map<String, dynamic> queryParameters,
  );

  @override
  String toString() {
    return '$basicAuth';
  }
}
