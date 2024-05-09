import 'dart:convert';

import 'package:frontend/model/asn_status.dart';
import 'package:frontend/model/po_status.dart';
import 'asn.dart';

class PurchaseOrder {
  int id;
  String poIdentification;
  String name;
  String supplier;
  int receivedItems;
  int totalItems;
  PoStatus status;
  List<Asn> asns;

  PurchaseOrder(
      {required this.id,
      required this.poIdentification,
      required this.name,
      required this.supplier,
      required this.receivedItems,
      required this.totalItems,
      required this.status,
      required this.asns});

// TODO: verify enum that comes from the API
// TODO: error handling for invalid values / fields and null treatment

  PurchaseOrder.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        poIdentification = json['poIdentification'],
        name = json['name'],
        supplier = json['supplier'],
        receivedItems = json['receivedItems'],
        totalItems = json['totalItems'],
        status =
            PoStatus.values.firstWhere((e) => e.toString() == json['state']),
        asns = json['asNs'].map<Asn>((json) {
          return Asn.fromJson(json);
        }).toList();

  void createAsnList(List<Asn> asnList){
    asns = asnList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poIdentification'] = poIdentification;
    data['name'] = name;
    data['supplier'] = supplier;
    data['receivedItems'] = receivedItems;
    data['totalItems'] = totalItems;
    data['state'] = status.toString();
    data['asNs'] = jsonEncode(asns);
    return data;
  }


  bool allAsnsBooked() {
    return asns.every((element) => element.status == ASNStatus.booked);
  }

  bool allAsnsCancelled() {
    return asns.every((element) => element.status == ASNStatus.cancelled);
  }

  bool noCreatedAsnsExist() {
    return asns.isEmpty;
  }

  int getAsnsNumber() {
    return asns.length;
  }

  List<Asn> getAsns() {
    return asns;
  }

  closedAsns() {
    return asns
        .where((element) =>
            element.status == ASNStatus.received ||
            element.status == ASNStatus.cancelled)
        .length;
  }

  Asn? nextAsn() {
    return asns.firstWhere((element) =>
        !(element.status == ASNStatus.received ||
            element.status == ASNStatus.cancelled));
  }

  openAsn() {
    return 4;
  }

  bool allAsnsReceived() {
    return asns.every((element) => element.status == ASNStatus.received);
  }

  bool checkIfAsnsExists(String shippingReference) {
    return asns
        .any((element) => element.shippingReference == shippingReference);
  }

  @override
  String toString() {
    return 'PurchaseOrder{id: $id, poIdentification: $poIdentification, name: $name, supplier: $supplier, receivedItems: $receivedItems, totalItems: $totalItems, status: $status, ASNs: $asns}';
  }
}
