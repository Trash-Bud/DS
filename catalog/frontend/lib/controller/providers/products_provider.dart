import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:frontend/controller/fetchers/products_fetcher.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/model/variant.dart';

class ProductsProvider extends ChangeNotifier {
  final Map<int, List<Variant>> _variants = {};
  List<Product> _products = [];
  bool _loadedProductsOnce = false;
  final Map<int, bool> _loadedVariantsOnce = {1: false};
  int? numberOfVariantPages;

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  UnmodifiableMapView<int, List<Variant>> get variants =>
      UnmodifiableMapView(_variants);

  Future<bool> getAllProducts({force = false}) async {
    if (!force && (_products.isNotEmpty || _loadedProductsOnce)) {
      return true;
    }

    _loadedProductsOnce = true;

    try {
      _products = await fetchAllProducts();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getVariants(
      {pageNumber = 1, searchInput, brand, force = false}) async {
    if (!force &&
        (_variants[pageNumber]?.isNotEmpty ??
            false || (_loadedVariantsOnce[pageNumber] ?? false))) {
      return true;
    }

    await getAllProducts(force: true);

    if (numberOfVariantPages == null) {
      if (!(await getNumberOfVariantPages())) {
        return false;
      }
    }

    _loadedVariantsOnce[pageNumber] = true;
    try {
      _variants[pageNumber] = await fetchVariants(_products,
          pageNumber: pageNumber, searchInput: searchInput, brandId: brand);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getNumberOfVariantPages({searchInput, brand}) async {
    try {
      numberOfVariantPages = await fetchNumberOfVariantPages(
          searchInput: searchInput, brandId: brand);

      if (numberOfVariantPages == 0) numberOfVariantPages = 1;
      return true;
    } catch (e) {
      return false;
    }
  }
}
