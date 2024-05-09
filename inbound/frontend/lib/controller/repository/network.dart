import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class Network {
  String root = dotenv.env['BACKEND_URL'] ?? "BACKEND_URL not found";
  Future<String> get(String path,
      {Map<String, String> queryParams = const {},
      Map<String, String> headers = const {}}) async {
    try {
      Uri url = Uri.parse(root + path);
      if (queryParams.isNotEmpty) {
        url = url.replace(queryParameters: queryParams);
      }

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        throw response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  /*
   * Makes an HTTP post request.
   * Upon error, returns the error message if available, otherwise returns a generic message with the error code.
   */
  Future<String> post(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {}}) async {
    try {
      Uri url = Uri.parse(root + path);
      String data = json.encode(body);
      http.Response response =
          await http.post(url, body: data, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        Map? errors = json.decode(response.body)["errors"];
        String errorMsg =
            "Network Request failed with errorCode: ${response.statusCode.toString()}";
        if (errors != null && errors.isNotEmpty) {
          List<dynamic> errorList = errors[
              errors.keys.first]; // Display the errors of the first field
          if (errorList.isNotEmpty) {
            errorMsg = errorList.first;
          }
        }

        throw errorMsg;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> multiPartPost(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      Map<String, List<int>> files = const {},
      Map<String, dynamic> queryParameters = const {}}) async {
    try {
      String queryString = Uri(queryParameters: queryParameters).query;
      Uri url = Uri.parse("$root$path?$queryString");

      var request = http.MultipartRequest("POST", url);
      request.headers.addAll(headers);
      request.fields.addAll(body.map((x, y) => MapEntry(x, y.toString())));

      for (dynamic key in files.keys) {
        request.files
            .add(http.MultipartFile.fromBytes(key, files[key]!, filename: key));
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.stream.toString();
      } else {
        // Read body data stream
        String responseBody = await response.stream.bytesToString();
        String errorMsg =
            parseErrFromBody(responseBody, response.statusCode);

        throw errorMsg;
      }
    } catch (e) {
      rethrow;
    }
  }

  void downloadFile(String path) {
    Uri url = Uri.parse(root + path);
    html.window.open(url.toString(), "_blank");
  }

  Future<String> put(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {}}) async {
    try {
      Uri url = Uri.parse(root + path);
      String data = json.encode(body);
      http.Response response =
          await http.put(url, headers: headers, body: data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        String errorMsg =
            parseErrFromBody(response.body, response.statusCode);

        throw errorMsg;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delete(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {}}) async {
    try {
      Uri url = Uri.parse(root + path);
      String data = json.encode(body);
      http.Response response =
          await http.delete(url, headers: headers, body: data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        String errorMsg =
            parseErrFromBody(response.body, response.statusCode);

        throw errorMsg;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> patch(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {}}) async {
    try {
      Uri url = Uri.parse(root + path);
      String data = json.encode(body);
      http.Response response =
          await http.patch(url, headers: headers, body: data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        String errorMsg =
            parseErrFromBody(response.body, response.statusCode);

        throw errorMsg;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Parses the error message from request's body
  String parseErrFromBody(responseBody, statusCode) {
    Map? responseMap = json.decode(responseBody);
    String errorMsg =
        "Network Request failed with errorCode: ${statusCode.toString()}";

    if (responseMap != null && responseMap.containsKey("error")) {
      errorMsg = responseMap["error"];
    }

    return errorMsg;
  }
}
