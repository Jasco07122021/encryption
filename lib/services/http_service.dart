import 'dart:convert';

import 'package:http/http.dart';

class HttpService{
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "mobile.unired.uz";
  static String SERVER_PRODUCTION = "mobile.unired.uz";

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  static String API_SEND = '/v4/demo-test';

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static Future<String?> POST(Map<String, dynamic> body) async {
    var uri = Uri.https(getServer(), API_SEND);
    var response = await post(uri, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Map<String, String> bodyNote(String result) {
    Map<String, String> body = {};
    body.addAll({
      'data': result
    });
    return body;
  }

  static bool parseJson(String json){
    Map<String,dynamic> response = jsonDecode(json);
    return response['status']??false;
  }
}