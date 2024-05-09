import 'dart:convert';

import 'package:frontend/model/brand.dart';
import 'package:frontend/controller/network.dart';

Future<List<Brand>> fetchAllBrands() async {
  var response = await getBackend('brands');
  if (!responseIsOk(response)) {
    throw Exception('Failed to load brands');
  }
  var brands = json.decode(response.body)["brands"] as List;
  var brandsList = brands.map((b) => Brand.fromJson(b)).toList();
  return brandsList;
}
