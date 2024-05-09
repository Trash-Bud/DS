import 'package:flutter/material.dart';
import 'package:frontend/controller/providers/brands_provider.dart';
import 'package:frontend/controller/providers/products_provider.dart';
import 'package:frontend/model/variant.dart';
import 'package:frontend/view/common/constants.dart';
import 'package:frontend/view/common/base_page.dart';
import 'package:frontend/view/add_variant_popup.dart';
import 'package:frontend/view/import_products_page.dart';
import 'package:frontend/view/variants_page/variant_row.dart';
import 'package:pager/pager.dart';
import 'package:provider/provider.dart';

import 'package:frontend/model/brand.dart';

class VariantsPage extends StatefulWidget {
  static const route = '/variants';

  const VariantsPage({super.key});

  @override
  VariantsPageState createState() => VariantsPageState();
}

class VariantsPageState extends State<VariantsPage> {
  int _currentPage = 1;
  String searchInput = '';
  late Brand selectedBrand;

  @override
  Widget build(BuildContext context) {
    selectedBrand = context.watch<BrandsProvider>().currentBrand;
    Provider.of<BrandsProvider>(context, listen: true).addListener(() {
      selectedBrand =
          Provider.of<BrandsProvider>(context, listen: false).currentBrand;
      updatePage(context);
    });

    return BasePage(
        content: Column(
      children: [
        _pageTitle(context),
        _tableHeader(["Product Name", "Supplier", "Type", "Family", "Variant"]),
        _tableRows(context),
        _paginator(context)
      ],
    ));
  }

  Widget _pageTitle(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Variants List",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Flexible(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: selectedBrand.id == unknownBrand.id
                    ? null
                    : () {
                        Navigator.pushNamed(context, ImportPage.route);
                      },
                child: const Text('Import Products'),
              ),
            ),
            Flexible(
                child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search for variants...',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.cyan),
              ),
              onChanged: (text) => setState(() {
                searchInput = text;
                updatePage(context);
              }),
            )),
            Flexible(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: selectedBrand.id == unknownBrand.id
                  ? null
                  : () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddVariantPopup();
                          });
                    },
              child: const Text('Create Variant'),
            )),
          ],
        ));
  }

  Widget _tableHeader(List<String> columnNames) => Container(
        color: const Color.fromRGBO(236, 236, 236, 1),
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            ...columnNames
                .map((name) =>
                    Flexible(child: SizedBox(width: 350, child: Text(name))))
                .toList(),
            const SizedBox(
              width: 50,
            )
          ],
        ),
      );

  Widget _tableRows(context) {
    return Consumer<ProductsProvider>(
      builder: (context, productsProvider, child) {
        List<Variant> variants = productsProvider.variants[_currentPage] ?? [];
        return Expanded(
            child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                width: MediaQuery.of(context).size.width,
                child: variants.isEmpty
                    ? const Center(
                        child: Text("No variants found.",
                            style: TextStyle(fontSize: 20)))
                    : ListView(
                        children: variants
                            .map((variant) => VariantRow(
                                variant: variant, pageNumber: _currentPage))
                            .toList())));
      },
    );
  }

  Widget _paginator(BuildContext context) {
    int? totalPages = context.watch<ProductsProvider>().numberOfVariantPages;

    return Pager(
      currentPage: _currentPage,
      totalPages: totalPages ?? 5,
      onPageChanged: (page) {
        Provider.of<ProductsProvider>(context, listen: false).getVariants(
            pageNumber: page,
            searchInput: searchInput,
            brand: selectedBrand.id,
            force: true);
        setState(() {
          _currentPage = page;
        });
      },
    );
  }

  void updatePage(context) {
    Provider.of<ProductsProvider>(context, listen: false)
        .getNumberOfVariantPages(
      searchInput: searchInput,
      brand: selectedBrand.id,
    );

    Provider.of<ProductsProvider>(context, listen: false).getVariants(
        searchInput: searchInput, brand: selectedBrand.id, force: true);
    _currentPage = 1;
  }
}
