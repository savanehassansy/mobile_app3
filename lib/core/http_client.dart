import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jmoov/core/vars.dart' as vars;

typedef Response = http.Response;
typedef Request = http.Request;

class Http {
  static final Http _http = Http._();
  String _baseUrl = vars.baseUrl;

  Http._();

  static Http get instance {
    return _http;
  }

  set baseUrl(String value) {
    _baseUrl = value;
  }

  Future<Response> get(String uri, {Map<String, String>? headers}) {
    return http.get(Uri.parse("$_baseUrl$uri"), headers: headers);
  }

  Future<Response> post(String uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return http.post(
      Uri.parse("$_baseUrl$uri"),
      body: body,
      encoding: encoding,
      headers: headers,
    );
  }

  Future<Response> put(String uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return http.put(
      Uri.parse("$_baseUrl$uri"),
      body: body,
      encoding: encoding,
      headers: headers,
    );
  }

  Future<Response> patch(String uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return http.patch(
      Uri.parse("$_baseUrl$uri"),
      body: body,
      encoding: encoding,
      headers: headers,
    );
  }

  Future<Response> delete(String uri,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return http.delete(
      Uri.parse("$_baseUrl$uri"),
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }
}
