import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:frontend/controller/repository/asn_repository.dart';
import 'package:frontend/controller/repository/purchase_order_repository.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/model/page_state.dart';
import 'package:frontend/controller/provider/table_pagination_controller.dart';

class AsnChangeNotifier extends ChangeNotifier {
  PageState _mainPageState = PageState.initial;
  PageState _mainPageRequestState = PageState.initial;

  PageState get mainPageState => _mainPageState;

  PageState get mainPageRequestSate => _mainPageRequestState;
  final AsnRepository asnApi;
  final PurchaseOrderRepository purchaseOrderApi;
  List<Asn> asns = [];
  String errorMessage = "";
  String searchQuery = "";
  String asnStateFilter = "";

  late final PaginationInfo _paginationInfo;

  Future<String?> retrievePoNameFromASN(Asn asn) async {
    if (asn.poIdentification == null) return null;
    final po =
        await purchaseOrderApi.getPurchaseOrderById(asn.poIdentification!);
    return Future.value(po?.name);
  }

  AsnChangeNotifier(this.asnApi, this.purchaseOrderApi) {
    fetchAsns();
    _paginationInfo = PaginationInfo(fetchFunction: fetchPage);
  }

  Future<void> uploadAsnFile(List<int> file, dynamic poID,
      {Map<String, dynamic> body = const {},
      Map<String, String> headers = const {},
      Map<String, dynamic> queryParameters = const {}}) async {
    Map<String, dynamic> nQueryParameters = HashMap();
    nQueryParameters.addAll(queryParameters);
    if (poID != null) {
      nQueryParameters["poID"] = poID;
    }
    _mainPageRequestState = PageState.loading;
    try {
      await AsnRepository.instance
          .uploadAsnFile(body, headers, file, nQueryParameters);
      _mainPageRequestState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> fetchAsns(
      {String textQuery = "",
      String asnState = "",
      int offset = 0,
      int limit = 5,
      bool notifyBeforeListen = true}) async {
    _mainPageState = PageState.loading;
    notifyListeners();
    try {
      Map<String, Object> response = await asnApi.getAsns(
          textQuery: textQuery,
          asnState: asnState,
          offset: offset,
          limit: limit);

      asns = response["asns"] as List<Asn>;

      for (Asn asn in asns) {
        if (asn.poIdentification != null) {
          asn.poName = await retrievePoNameFromASN(asn);
        }
      }

      response["totalResults"] != null
          ? _paginationInfo.total = response["totalResults"] as int
          : _paginationInfo.total = asns.length;

      _mainPageState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageState = PageState.error;
    }

    // Save the last searched query and state
    if (searchQuery != textQuery) {
      searchQuery = textQuery;
    }
    if (asnStateFilter != asnState) {
      asnStateFilter = asnState;
    }

    notifyListeners();
  }

  Future<void> cancelAsn(int id) async {
    _mainPageState = PageState.loading;
    try {
      await asnApi.cancelAsn(id);
      asns.firstWhere((element) => element.id == id).status =
          ASNStatus.cancelled;
      _mainPageState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> fetchPage(int offset, int limit) async {
    await fetchAsns(offset: offset, limit: limit, notifyBeforeListen: false);
  }

  get paginationInfo => _paginationInfo;

  Future<void> downloadAsnFile(int id) async {
    _mainPageState = PageState.loading;
    try {
      await asnApi.downloadAsnFile(id);
      _mainPageState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> downloadAsnTemplate() async {
    _mainPageState = PageState.loading;
    try {
      await asnApi.downloadAsnTemplate();
      _mainPageState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> bookAsn(int id) async {
    _mainPageState = PageState.loading;
    try {
      await asnApi.bookAsn(id);
      asns.firstWhere((element) => element.id == id).status = ASNStatus.booked;
      _mainPageState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageState = PageState.error;
    }
    notifyListeners();
  }

  Future<void> sendReceptionReceived(int id) async {
    _mainPageState = PageState.loading;
    try {
      await asnApi.sendReceptionReceived(id);
      _mainPageState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageState = PageState.error;
    }
    notifyListeners();
  }

  editAsn(
      int id, Map<String, dynamic> body, Map<String, String> headers) async {
    _mainPageRequestState = PageState.loading;
    try {
      await asnApi.editAsn(id, body, headers);

      Map<String, Object> response = await asnApi.getAsns(
          textQuery: searchQuery,
          asnState: asnStateFilter,
          offset: _paginationInfo.offset,
          limit: _paginationInfo.limit);

      asns = response["asns"] as List<Asn>;
      response["totalResults"] != null
          ? _paginationInfo.total = response["totalResults"] as int
          : _paginationInfo.total = asns.length;

      _mainPageRequestState = PageState.loaded;
    } catch (e) {
      errorMessage = '$e';
      _mainPageRequestState = PageState.error;
    }
    notifyListeners();
  }
}
