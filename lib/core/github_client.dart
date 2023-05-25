import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constants.dart';

class NetWorkException implements Exception {
  int statuscode;
  String? message;
  NetWorkException(this.statuscode, {this.message});
}

class GithubClient {
  GithubClient({
    http.Client? httpClient,
    this.baseUrl = "api.github.com",
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  final Map<String, String> _headers = {
    "X-OAuth-Scopes": "repo, user",
  };

  Future<Map<String, dynamic>> putResource(
    String path,
    Map<String, dynamic> data, {
    Map<String, String>? queryParams,
  }) async {
    Uri uri = await _createUri(path, queryParams: queryParams);
    final dataString = jsonEncode(data);
    final response = await httpClient.put(
      uri,
      body: dataString,
      headers: _headers,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> updateResource(
    String path,
    Map<String, dynamic> data, {
    Map<String, String>? queryParams,
  }) async {
    Uri uri = await _createUri(path, queryParams: queryParams);
    final dataString = jsonEncode(data);
    final response = await httpClient.patch(
      uri,
      body: dataString,
      headers: _headers,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> deleteResource(String path) async {
    Uri uri = await _createUri(path);
    final response = await httpClient.delete(
      uri,
      headers: _headers,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> fetch(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    Uri uri = await _createUri(path, queryParams: queryParams);

    final response = await httpClient.get(
      uri,
      headers: _headers,
    );

    return _handleResponse(response);
  }

  Future<List<dynamic>> fetchList(
    String path, {
    String? url,
    Map<String, String>? queryParams,
  }) async {
    Uri uri = await _createUri(path, queryParams: queryParams);

    final response = await httpClient.get(
      uri,
      headers: _headers,
    );

    return jsonDecode(response.body) as List;
  }

  Future<dynamic> fetchFromUrl(
    String url, {
    Map<String, String>? queryParams,
  }) async {
    Uri uri = Uri();

    uri = Uri.parse(url);
    if (queryParams != null && queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }
    final response = await httpClient.get(
      uri,
      headers: _headers,
    );
    final result = jsonDecode(response.body);
    if (result == List<dynamic>) {
      return result as List;
    } else {
      return result;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode > 204) {
      throw NetWorkException(response.statusCode);
    }
    try {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      throw Exception(e);
    }
    return {};
  }

  Future<Uri> _createUri(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    Map<String, String> queryParams0 = {};
    if (queryParams != null) {
      queryParams0.addAll(queryParams);
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(Constants.authToken);
      if (!_headers.containsKey("Authorization")) {
        _headers["Authorization"] = "Bearer $token";
      }
    } catch (e) {
      rethrow;
    }
    final uri = Uri.https(baseUrl, path, queryParams0);
    return uri;
  }
}
