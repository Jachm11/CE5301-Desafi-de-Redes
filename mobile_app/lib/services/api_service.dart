import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> postLogin(
    String username, String password, String host, int port) async {
  final Map<String, dynamic> data = {
    "host": host,
    "port": port,
    "username": username,
    "password": password
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.post(Uri.parse('http://127.0.0.1:5000/connect'),
      headers: headers, body: json.encode(data));

  return response;
}

Future<http.Response> getUserActivities() async {
  var response = await http.get(Uri.parse('getActivitiesUrl'));

  return response;
}
