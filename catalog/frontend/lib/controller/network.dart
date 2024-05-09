import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:universal_html/html.dart' as html;

String backendUrl = dotenv.env['BACKEND_URL'] ?? "http://localhost:8080";

bool responseIsOk(Response response) {
  return response.statusCode >= 200 && response.statusCode < 300;
}

Future<Response> getBackend(String endpoint,
    {Map<String, String>? headers}) async {
  headers ??= {};
  Uri url = Uri.parse('$backendUrl/$endpoint');
  headers.putIfAbsent('Access-Control-Allow-Origin', () => 'true');
  try {
    return http.get(url, headers: headers);
  } catch (e) {
    return Response('', 404);
  }
}

Future<Response> postBackend(String endpoint,
    {Map<String, String>? headers,
    Map<String, dynamic> body = const {},
    Map<String, String> query = const {}}) async {
  headers ??= {};
  Uri url = Uri.parse('$backendUrl/$endpoint');
  if (query.isNotEmpty) {
    url = url.replace(queryParameters: query);
  }
  String data = json.encode(body);
  headers.putIfAbsent('Access-Control-Allow-Origin', () => 'true');
  try {
    return http.post(url, body: data, headers: headers);
  } catch (e) {
    return Response('', 404);
  }
}

Future<Response> putBackend(String endpoint,
    {Map<String, String>? headers,
    Map<String, dynamic> body = const {}}) async {
  headers ??= {};
  Uri url = Uri.parse('$backendUrl/$endpoint');
  String data = json.encode(body);
  headers.putIfAbsent('Access-Control-Allow-Origin', () => 'true');
  try {
    return http.put(url, body: data, headers: headers);
  } catch (e) {
    return Response('', 404);
  }
}

Future<Response> putBackendJson(String endpoint,
    {Map<String, dynamic> body = const {}}) async {
  Map<String, String> headers = {};
  headers.putIfAbsent('Content-type', () => 'application/json');
  body.removeWhere((key, value) => value == null || value == '');
  return putBackend(endpoint, headers: headers, body: body);
}

Future<Response> postBackendJson(String endpoint,
    {Map<String, dynamic> body = const {},
    Map<String, String> query = const {}}) async {
  Map<String, String> headers = {};
  headers.putIfAbsent('Content-type', () => 'application/json');
  body.removeWhere((key, value) => value == null || value == '' || value == []);
  return postBackend(endpoint, headers: headers, body: body, query: query);
}

Future<Response> postBackendMultipart(
    String endpoint, List<int> data, String fileName, String mime,
    {Map<String, String> query = const {}}) async {
  Uri url = Uri.parse('$backendUrl/$endpoint');
  if (query.isNotEmpty) {
    url = url.replace(queryParameters: query);
  }

  Map<String, String> errorRsponse = {'error': 'Wrong file extension.'};
  if (mime.isEmpty) return Response(json.encode(errorRsponse), 415);

  MediaType mediaType = MediaType.parse(mime);
  var request = http.MultipartRequest('POST', url);
  request.files.add(http.MultipartFile.fromBytes('file', data,
      filename: fileName, contentType: mediaType));
  return http.Response.fromStream(await request.send());
}

void downloadFile(String endpoint) {
  Uri url = Uri.parse('$backendUrl/$endpoint');
  html.window.open(url.toString(), "_blank");
}
