import 'package:frontend/model/asn_status.dart';
import 'package:frontend/model/entities/product.dart';

List<dynamic> interpretProductList(List<dynamic> json, int num) {
  List<Product> products = json.map<Product>((json1) {
    return Product.fromJson(json1);
  }).toList();
  return products;
}

class Asn {
  ASNStatus status;
  int id;
  String shippingReference;
  String? warehouse;
  String? address;
  DateTime? deliveryDate;
  String? carrier; // option
  String? cargoType; // optional
  String? shipperContact; // optional
  int? poIdentification; // optional
  DateTime? purchaseOrderDate;
  List<dynamic>? productList;
  String? poName;

  Asn({
    required this.id,
    required this.shippingReference,
    required this.warehouse,
    required this.deliveryDate,
    required this.carrier,
    required this.cargoType,
    required this.shipperContact,
    required this.poIdentification,
    required this.purchaseOrderDate,
    required this.status,
    required this.address,
    this.poName,
  });

  Asn.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        shippingReference = json['shipmentReference'],
        warehouse = (json['warehouse'] == "") ? null : json['warehouse'],
        address = (json['address'] == "") ? null : json['address'],
        deliveryDate = DateTime.parse(json['expectedDeliveryDate']),
        carrier = (json['carrierName'] == "") ? null : json['carrierName'],
        cargoType = (json['type'] == "") ? null : json['type'],
        shipperContact =
            (json['shipperContact'] == "") ? null : json['shipperContact'],
        poIdentification = json['purchaseOrderId'],
        purchaseOrderDate = (json['purchaseOrderDate'] == null)
            ? null
            : DateTime.parse(json['purchaseOrderDate']),
        status =
            ASNStatus.values.firstWhere((e) => e.toString() == json['state']),
        productList = interpretProductList(json['productList'], json['id']);

  get isReceived => deliveryDate != null;

  get isWarehouseChecked => warehouse != null;

  get stockAllocated => shipperContact != null;

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shippingReference'] = shippingReference;
    data['warehouse'] = warehouse;
    data['deliveryDate'] = deliveryDate;
    data['carrier'] = carrier;
    data['cargoType'] = cargoType;
    data['shipperContact'] = shipperContact;
    data['poIdentification'] = poIdentification;
    data['purchaseOrderDate'] = purchaseOrderDate;
    data['address'] = address;
    data['status'] = status.toString();
    return data;
  }

  @override
  String toString() {
    return 'ASN{id: $id, shippingReference: $shippingReference, warehouse: $warehouse, deliveryDate: $deliveryDate, carrier: $carrier, cargoType: $cargoType, shipperContact: $shipperContact, poIdentification: $poIdentification, purchaseOrderDate: $purchaseOrderDate, productList: $productList, address: $address, status: $status}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Asn && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
