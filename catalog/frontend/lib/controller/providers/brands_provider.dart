import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:frontend/controller/fetchers/brands_fetcher.dart';
import 'package:frontend/model/brand.dart';
import 'package:frontend/view/common/constants.dart';

class BrandsProvider extends ChangeNotifier {
  List<Brand> _brands = [];
  Brand _currentBrand = unknownBrand;
  bool _loadedOnce = false;

  UnmodifiableListView<Brand> get brands => UnmodifiableListView(_brands);

  Future<bool> getAllBrands({force = false}) async {
    if (!force && (_brands.isNotEmpty || _loadedOnce)) {
      return true;
    }
    _loadedOnce = true;
    try {
      _brands = await fetchAllBrands();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Brand get currentBrand => _currentBrand;

  set currentBrand(Brand brand) {
    _currentBrand = brand;
    notifyListeners();
  }
}
