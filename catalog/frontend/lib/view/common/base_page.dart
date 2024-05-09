import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/brands_provider.dart';
import 'package:frontend/model/brand.dart';
import 'package:frontend/view/common/constants.dart';
import 'package:frontend/view/common/utils.dart';
import 'package:provider/provider.dart';

class BasePage extends StatelessWidget {
  final Widget content;

  const BasePage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      _chooseBrand(context),
      Expanded(
          child: Container(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
              child: content)),
    ]));
  }

  // TODO: this is a temporary solution to simulate an authentication
  _chooseBrand(BuildContext context) {
    Provider.of<BrandsProvider>(context).getAllBrands().then((success) {
      if (!success) {
        showStandardDialog(context, 'Information', 'Failed to load brands!');
      }
    });
    return Consumer<BrandsProvider>(builder: (context, brandsProvider, child) {
      List<Brand> brands = brandsProvider.brands;
      brands = [unknownBrand, ...brands];

      return DropdownButton<Brand>(
        value: brandsProvider.currentBrand,
        icon: const Icon(Icons.arrow_downward),
        onChanged: (Brand? value) {
          brandsProvider.currentBrand = value!;
        },
        items: brands.map<DropdownMenuItem<Brand>>((Brand value) {
          return DropdownMenuItem<Brand>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
      );
    });
  }
}
