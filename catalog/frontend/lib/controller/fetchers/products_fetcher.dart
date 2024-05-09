import 'dart:convert';

import 'package:frontend/model/product.dart';
import 'package:frontend/controller/network.dart';
import 'package:frontend/model/variant.dart';
import 'package:frontend/view/common/constants.dart';

Future<List<Product>> fetchAllProducts() async {
  var response = await getBackend('products');
  if (!responseIsOk(response)) {
    throw Exception('Failed to load products');
  }
  var products = json.decode(response.body)["products"] as List;
  var productsList = products.map((p) => Product.fromJson(p)).toList();
  return productsList;
}

Future<List<Variant>> fetchVariants(List<Product> products,
    {pageNumber, searchInput, brandId}) async {
  if (brandId == unknownBrand.id) brandId = null;
  var response = await getBackend(
      'variants?pageNumber=$pageNumber${(searchInput != null) ? '&q=$searchInput' : ''}${(brandId != null) ? '&brandId=$brandId' : ''}');

  if (!responseIsOk(response)) {
    throw Exception('Failed to load variants');
  }
  var variants = json.decode(response.body)["variants"] as List;
  try {
    return variants.map((variant) {
      Product product =
          products.firstWhere((product) => product.id == variant["productId"]);
      return Variant.fromJson(variant, product);
    }).toList();
  } catch (e) {
    throw Exception('Failed to parse variants');
  }
}

Future<int> fetchNumberOfVariantPages({searchInput, brandId}) async {
  if (brandId == unknownBrand.id) brandId = null;
  var response = await getBackend(
      'variants/pages${(searchInput != null) ? '?q=$searchInput' : ''}${(brandId != null) ? '&brandId=$brandId' : ''}');

  if (!responseIsOk(response)) {
    throw Exception('Failed to load number of variant pages');
  }
  return json.decode(response.body)["pages"];
}
