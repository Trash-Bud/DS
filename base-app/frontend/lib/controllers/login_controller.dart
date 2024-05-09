import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

/// Sends the login request to a Mock API.
Future<http.Response> sendRequest(String user, String pass) async {
  const int loginRequestTimeout = 10;

  const String url = "https://63591192ff3d7bddb9980c3a.mockapi.io/maersk/login";
  final Map<String, String> headers = {'username': user, 'password': pass};

  return await http
      .get(Uri.parse(url), headers: headers)
      .timeout(const Duration(seconds: loginRequestTimeout));
}

/// Handles the login.
Future<List> login(
    String user,
    String pass,
    TextEditingController usernameController,
    TextEditingController passwordController) async {
  bool loginSuccess = false;
  bool isAdmin = false;

  try {
    http.Response response = await sendRequest(user, pass);
    final decodedResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      usernameController.clear();

      loginSuccess = decodedResponse['authorized'];
      isAdmin = decodedResponse['admin'];
    }

    passwordController.clear();

    return [loginSuccess, isAdmin];
  } on TimeoutException catch (_) {
    return [false, false];
  }
}
