import 'package:flutter/cupertino.dart';
import 'package:frontend/controller/repository/purchase_order_repository.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';

import 'package:frontend/model/page_state.dart';
import 'package:frontend/controller/provider/table_pagination_controller.dart';

//TODO: remove repeated notify listeners by making the widgets where these requests are made stateful
class PurchaseOrderChangeNotifier extends ChangeNotifier {
  PageState _mainPageState = PageState.initial;
  PageState _mainPageRequestState = PageState.initial;
  PageState get mainPageState => _mainPageState;
  PageState get mainPageRequestSate => _mainPageRequestState;
  final PurchaseOrderRepository purchaseOrderApi;
  List<PurchaseOrder> purchaseOrders = [];
  late final PaginationInfo _paginationInfo;

  String errorMessage = "";
  String searchQuery = "";
  String poStateFilter = "";

  PurchaseOrderChangeNotifier(this.purchaseOrderApi) {
    fetchPurchaseOrders();
    _paginationInfo = PaginationInfo(fetchFunction: fetchPage);
  }

  Future<void> fetchPurchaseOrders(
      {String textQuery = "",
      String poState = "",
      int offset = 0,
      int limit = 5,
      bool notifyBeforeLoading = true}) async {
    _mainPageState = PageState.loading;
    if(notifyBeforeLoading) notifyListeners();
    try {
      // Dynamic here is questionable
      Map<String, Object> response = await purchaseOrderApi.getPurchaseOrders(
          textQuery: textQuery, poState: poState, offset: offset, limit: limit);

      purchaseOrders = response["purchaseOrders"] as List<PurchaseOrder>;

      response["totalResults"] != null
          ? _paginationInfo.total = response["totalResults"] as int
          : _paginationInfo.total = purchaseOrders.length;

      _mainPageState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageState = PageState.error;
    }

    // Save the last searched query
    if (searchQuery != textQuery) {
      searchQuery = textQuery;
    }
    if (poStateFilter != poState) {
      poStateFilter = poState;
    }
    notifyListeners();
  }

  Future<PurchaseOrder?> getPurchaseOrderById(int id) async {
    _mainPageRequestState = PageState.loading;
    PurchaseOrder? po;
    try {
      po = await purchaseOrderApi.getPurchaseOrderById(id);
      _mainPageRequestState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
    return po;
  }

  Future<void> cancelPurchaseOrder(int id) async {
    _mainPageRequestState = PageState.loading;
    try {
      await purchaseOrderApi.cancelPurchaseOrder(id);
      purchaseOrders.firstWhere((element) => element.id == id).status =
          PoStatus.cancelled;
      _mainPageRequestState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> createPurchaseOrder(
      Map<String, dynamic> body, Map<String, String> headers) async {
    _mainPageRequestState = PageState.loading;
    try {
      await purchaseOrderApi.createPurchaseOrder(body, headers);
      //TODO: When the backend starts returning the newly created PO replace this request
      final Map<String, Object> response = await purchaseOrderApi.getPurchaseOrders();
      purchaseOrders = response["purchaseOrders"] as List<PurchaseOrder>;

      _mainPageRequestState = PageState.loaded;
    } catch (e) {
      // print(e);
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> editPurchaseOrder(int id, Map<String, dynamic> body, Map<String, String> headers) async {
    _mainPageRequestState = PageState.loading;
    try {
      await purchaseOrderApi.editPurchaseOrder(id, body, headers);

      Map<String, Object> response = await purchaseOrderApi.getPurchaseOrders();
      purchaseOrders = response["purchaseOrders"] as List<PurchaseOrder>;
      _mainPageRequestState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }

  void cancelASNPurchaseOrder(int poID, int asnID) {
    _mainPageRequestState = PageState.loading;
    try{
      purchaseOrders.firstWhere((element) => element.id == poID)
          .asns.firstWhere((element) => element.id == asnID).status = ASNStatus.cancelled;
      _mainPageRequestState = PageState.loaded;
    }
    catch(e){
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> downloadPurchaseOrderFile(int id) async{
    _mainPageRequestState = PageState.loading;
    try{
      await purchaseOrderApi.downloadPurchaseOrderFile(id);
      _mainPageRequestState = PageState.loaded;
    }
    catch(e){
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }

  void bookASNPurchaseOrder(int poID, int asnID) {
    _mainPageRequestState = PageState.loading;
    try{
      purchaseOrders.firstWhere((element) => element.id == poID)
          .asns.firstWhere((element) => element.id == asnID).status = ASNStatus.booked;
      _mainPageRequestState = PageState.loaded;
    }
    catch(e){
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> archivePurchaseOrder(int id) async{
    _mainPageRequestState = PageState.loading;
    try{
      await purchaseOrderApi.archivePurchaseOrder(id);
      purchaseOrders.firstWhere((element) => element.id == id).status = PoStatus.archived;
      _mainPageRequestState = PageState.loaded;
    }
    catch(e){
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }


  Future<void> fetchPage(int offset, int limit) async {
    fetchPurchaseOrders(
        textQuery: searchQuery,
        poState: poStateFilter,
        offset: offset,
        limit: _paginationInfo.limit,
        notifyBeforeLoading: false);
  }

  get paginationInfo => _paginationInfo;
}
