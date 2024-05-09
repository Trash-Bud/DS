import 'package:frontend/model/product.dart';

class Variant {
  final Product product;
  final num? id;
  String barcode;
  String sku;
  String? prePackedItem;
  String variantDescription;
  String composition;
  String hscode;
  String country;
  String? gender;
  String? ageGroup;
  String? color;
  String? size;
  String? fabric;
  num width;
  num height;
  num depth;
  num weight;
  num? priceRetail;
  num? priceWholesale;
  num? cost;
  String currency;
  num? dangerous;
  num? unNumber;
  num? packingCode;
  bool isArchived = false;

  Variant(
      {required this.product,
      this.id,
      required this.sku,
      required this.barcode,
      this.prePackedItem,
      required this.variantDescription,
      required this.composition,
      required this.hscode,
      required this.country,
      this.gender,
      this.ageGroup,
      this.color,
      this.size,
      this.fabric,
      required this.width,
      required this.height,
      required this.depth,
      required this.weight,
      this.priceRetail,
      this.priceWholesale,
      this.cost,
      required this.currency,
      this.dangerous,
      this.unNumber,
      this.packingCode,
      required this.isArchived});

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': product.id,
        'barcode': barcode,
        'sku': sku,
        'prePackedItem': prePackedItem,
        'variantDescription': variantDescription,
        'composition': composition,
        'hscode': hscode,
        'country': country,
        'gender': gender,
        'ageGroup': ageGroup,
        'color': color,
        'size': size,
        'fabric': fabric,
        'width': width,
        'height': height,
        'depth': depth,
        'weight': weight,
        'priceRetail': priceRetail,
        'priceWholesale': priceWholesale,
        'cost': cost,
        'currency': currency,
        'dangerous': dangerous,
        'un': unNumber,
        'packingCode': packingCode,
        'isArchived': isArchived
      };

  static Variant fromJson(Map<String, dynamic> json, Product product) {
    return Variant(
        product: product,
        id: json['id'],
        sku: json['sku'],
        barcode: json['barcode'],
        variantDescription: json['variantDescription'],
        composition: json['composition'],
        hscode: json['hscode'],
        country: json['country'],
        gender: json['gender'],
        ageGroup: json['ageGroup'],
        color: json['color'],
        size: json['size'],
        fabric: json['fabric'],
        width: json['width'],
        height: json['height'],
        depth: json['depth'],
        weight: json['weight'],
        priceRetail: json['priceRetail'],
        priceWholesale: json['priceWholesale'],
        cost: json['cost'],
        currency: json['currency'],
        dangerous: json['dangerous'],
        unNumber: json['un'],
        packingCode: json['packingCode'],
        prePackedItem: json['prePackedItem'],
        isArchived: json['isArchived']);
  }
}
