import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  static String token = "";
  static const BASE_URL = "https://blumer.app/";

  static Future<String> getToken() async {
    return "3968dc68288646bc748e214d1f664cd94e2caef6";
  }

  static getHeaders(bool auth) async {
    return auth
        ? {
            "Authorization": "Token " + await getToken(),
            "Content-Type": "application/json"
          }
        : {"Content-Type": "application/json"};
  }

  static Future<dynamic> get(String path, {bool auth = true}) async {
    try {
      final response =
          await http.get(BASE_URL + path, headers: await getHeaders(auth));
      return getResponse(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<dynamic> post(String path, Map body, {bool auth = true}) async {
    try {
      final response = await http.post(BASE_URL + path,
          body: json.encode(body), headers: await getHeaders(auth));
      return getResponse(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  static dynamic getResponse(http.Response response) {
    final decodedJson = json.decode(utf8.decode(response.bodyBytes));
    switch (response.statusCode) {
      case 200:
        return decodedJson;
      case 201:
        return decodedJson;
      case 400:
        return Future.error(decodedJson);
      case 401:
        return Future.error(decodedJson);
    }
  }
}
