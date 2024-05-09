import 'dart:convert';
import 'package:frontend/model/entities/purchase_order.dart';
import 'network.dart';

class PurchaseOrderRepository {
  static final PurchaseOrderRepository _instance = PurchaseOrderRepository._();

  PurchaseOrderRepository._();

  static PurchaseOrderRepository get instance {
    return _instance;
  }

  Future<Map<String, Object>> getPurchaseOrders(
      {String textQuery = '',
      String poState = '',
      int offset = -1,
      int limit = -1}) async {
    Network requestController = Network();
    final queryParams = <String, String>{};
    if (textQuery != '') {
      queryParams['query'] = textQuery;
    }
    if (poState != '') {
      queryParams['state'] = poState;
    }

    if (offset != -1) queryParams['offset'] = offset.toString();
    if (limit != -1) queryParams['limit'] = limit.toString();

    try {
      var body = await requestController.get("purchase-orders",
          queryParams: queryParams);
      var list = jsonDecode(body)["purchaseOrders"];


      final response = <String, Object>{};
      List<PurchaseOrder> pos = list.map<PurchaseOrder>((json) {
        return PurchaseOrder.fromJson(json);
      }).toList();

      response['totalResults'] = jsonDecode(body)['totalResults'];
      response['purchaseOrders'] = pos;

      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<PurchaseOrder?> getPurchaseOrderById(int id) async {
    Network requestController = Network();

    try {
      var body = await requestController.get("purchase-orders/$id");
      var bodyDecode = jsonDecode(body);

      PurchaseOrder po = PurchaseOrder.fromJson(bodyDecode);
      return po;

    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelPurchaseOrder(int id) async {
    Network requestController = Network();
    try {
      await requestController.put("purchase-orders/$id/cancel");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> archivePurchaseOrder(int id) async {
    Network requestController = Network();
    try {
      await requestController.put("purchase-orders/$id/archive");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadPurchaseOrderFile(int id) async {
    Network requestController = Network();
    try {
      requestController.downloadFile("purchase-orders/$id/export");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createPurchaseOrder(
      Map<String, dynamic> body, Map<String, String> headers) async {
    Network requestController = Network();
    try {
      await requestController.post("purchase-orders/new",
          headers: headers, body: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editPurchaseOrder(int id, Map<String, dynamic> body, Map<String, String> headers) async {
    Network requestController = Network();
    try {
      await requestController.put("purchase-orders/$id",
          headers: headers, body: body);
    } catch (e) {
      rethrow;
    }
  }
}
