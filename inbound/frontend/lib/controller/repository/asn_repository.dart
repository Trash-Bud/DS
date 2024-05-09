import 'dart:collection';
import 'dart:convert';
import 'package:frontend/model/entities/asn.dart';
import 'network.dart';

class AsnRepository {
  static final AsnRepository _instance = AsnRepository._();

  AsnRepository._();

  static AsnRepository get instance {
    return _instance;
  }

  Future<Map<String, Object>> getAsns(
      {String textQuery = '',
      String asnState = '',
      int offset = -1,
      int limit = -1}) async {
    Network requestController = Network();

    try {
      final queryParams = <String, String>{};

      if (textQuery != '') {
        queryParams['query'] = textQuery;
      }
      if (asnState != '') {
        queryParams['state'] = asnState;
      }

      if (offset != -1) queryParams['offset'] = offset.toString();
      if (limit != -1) queryParams['limit'] = limit.toString();

      var body = await requestController.get("asn", queryParams: queryParams);

      Map<String, Object> response = <String, Object>{};

      var list = jsonDecode(body)["asn"];
      List<Asn> asns = list.map<Asn>((json) {
        return Asn.fromJson(json);
      }).toList();

      response["asns"] = asns;
      response['totalResults'] = jsonDecode(body)['totalResults'];

      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<void> uploadAsnFile(
      Map<String, dynamic> body,
      Map<String, String> headers,
      List<int> file,
      Map<String, dynamic> queryParameters) async {
    Network requestController = Network();
    try {
      Map<String, List<int>> files = HashMap();
      files['asnFile'] = file;
      await requestController.multiPartPost("asn/import",
          headers: headers,
          body: body,
          files: files,
          queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadAsnFile(int id) async {
    Network requestController = Network();
    try {
      requestController.downloadFile("asn/$id/export");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadAsnTemplate() async {
    Network requestController = Network();
    try {
      requestController.downloadFile("asn/template");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelAsn(int id) async {
    Network requestController = Network();
    try {
      await requestController.put("asn/$id/cancel");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> bookAsn(int id) async {
    Network requestController = Network();
    try {
      await requestController.post("kafka/reception-created/$id");
      await requestController.put("asn/$id/book");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendReceptionReceived(int id) async {
    Network requestController = Network();
    try {
      await requestController.post("kafka/reception-received/$id");
    } catch (e) {
      rethrow;
    }
  }

  editAsn(
      int id, Map<String, dynamic> body, Map<String, String> headers) async {
    Network requestController = Network();
    try {
      await requestController.put("asn/$id", headers: headers, body: body);
    } catch (e) {
      rethrow;
    }
  }
}
