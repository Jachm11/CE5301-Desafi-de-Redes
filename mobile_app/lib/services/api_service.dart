import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../managers/shared_local_store.dart';

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

Future<http.Response> postDisconnect() async {
  int sessionId = await SharedLocalStore.getSessionId();

  var response = await http.post(
    Uri.parse('http://127.0.0.1:5000/disconnect/${sessionId}'),
  );

  return response;
}

Future<http.Response> getSchema() async {
  int sessionId = await SharedLocalStore.getSessionId();

  final Map<String, dynamic> data = {"schema": "Cisco-NX-OS-device"};

  var headers = {"Content-Type": "application/json"};

  var response = await http.post(
      Uri.parse('http://127.0.0.1:5000/get_schema/${sessionId}'),
      body: json.encode(data),
      headers: headers);

  return response;
}

Future<http.Response> getSerial() async {
  int sessionId = await SharedLocalStore.getSessionId();

  var response = await http
      .get(Uri.parse('http://127.0.0.1:5000/get_serial/${sessionId}'));

  return response;
}

Future<http.Response> getLoopbacks() async {
  int sessionId = await SharedLocalStore.getSessionId();

  var response = await http
      .get(Uri.parse('http://127.0.0.1:5000/get_loopbacks/${sessionId}'));

  return response;
}

Future<http.Response> getCapabilities() async {
  int sessionId = await SharedLocalStore.getSessionId();

  var response = await http
      .get(Uri.parse('http://127.0.0.1:5000/get_capabilities/${sessionId}'));

  return response;
}

Future<http.Response> putAddLoopback(
    int loopbackNumber, String loopbackIp, String description) async {
  int sessionId = await SharedLocalStore.getSessionId();

  final Map<String, dynamic> data = {
    "loopback_number": loopbackNumber,
    "loopback_ip": loopbackIp,
    "description": description
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.put(
      Uri.parse('http://127.0.0.1:5000/add_loopback/${sessionId}'),
      headers: headers,
      body: jsonEncode(data));

  return response;
}

Future<http.Response> deleteLoopback(int loopbackNumber) async {
  int sessionId = await SharedLocalStore.getSessionId();

  final Map<String, dynamic> data = {
    "loopback_number": loopbackNumber,
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.delete(
      Uri.parse('http://127.0.0.1:5000/delete_loopback/${sessionId}'),
      headers: headers,
      body: jsonEncode(data));

  return response;
}

Future<http.Response> putEditConfig(String config) async {
  int sessionId = await SharedLocalStore.getSessionId();

  var headers = {"Content-Type": "application/json"};

  final Map<String, dynamic> data = {"config": config};
  print(jsonEncode(data));

  var response = await http.put(
      Uri.parse('http://127.0.0.1:5000/edit_config/${sessionId}'),
      headers: headers,
      body: jsonEncode(data));

  return response;
}
