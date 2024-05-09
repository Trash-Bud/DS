import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/controller/network.dart';
import 'package:frontend/controller/providers/brands_provider.dart';
import 'package:frontend/controller/providers/products_provider.dart';
import 'package:frontend/model/brand.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/model/variant.dart';
import 'package:frontend/view/common/right_popup_titled.dart';
import 'package:frontend/view/common/utils.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:frontend/view/common/constants.dart' as constants;

enum AddVariantMode { newVariant, newProduct, editVariant, editProduct }

class AddVariantPopup extends StatefulWidget {
  AddVariantPopup({super.key, this.variant});
  final Variant? variant;

  // hint, required, minLength, maxLength, isNumber
  final Map<String, Tuple5<String, bool, int?, int?, bool>> productTextFields =
      {
    'name': const Tuple5('Product name', true, null, 256, false),
    'description': const Tuple5('Product description', false, null, 256, false),
    'season': const Tuple5('Season', false, null, 256, false),
    'supplier': const Tuple5('Supplier', true, null, 256, false),
    'type': const Tuple5('Type', true, null, 256, false),
    'family': const Tuple5('Family', true, null, 256, false),
    'subFamily': const Tuple5('Subfamily', false, null, 256, false),
  };
  final Map<String, Tuple5<String, bool, int?, int?, bool>> variantTextFields =
      {
    'sku': const Tuple5('SKU', true, null, 256, false),
    'barcode': const Tuple5('Barcode', true, null, 128, false),
    'variantDescription':
        const Tuple5('Variant description', true, null, 256, false),
    'composition': const Tuple5('Composition', true, null, 256, false),
    'hscode': const Tuple5('HS code', true, 6, 15, false),
    'gender': const Tuple5('Gender', false, null, 256, false),
    'ageGroup': const Tuple5('Age Group', false, null, 256, false),
    'color': const Tuple5('Color', false, null, 256, false),
    'size': const Tuple5('Size', false, null, 256, false),
    'fabric': const Tuple5('Fabric', false, null, 256, false),
    'width': const Tuple5('Width', true, null, 256, true),
    'height': const Tuple5('Height', true, null, 256, true),
    'depth': const Tuple5('Depth', true, null, 256, true),
    'weight': const Tuple5('Weight', true, null, 256, true),
    'priceRetail': const Tuple5('Retail price', false, null, 256, true),
    'priceWholesale': const Tuple5('Wholesale price', false, null, 256, true),
    'cost': const Tuple5('Cost', false, null, 256, true),
    'un': const Tuple5('UN number', false, 4, 7, true),
  };

  // hint, items, required
  final Map<String, Tuple3<String, List<dynamic>, bool>> variantDropdownFields =
      {
    'prePackedItem':
        Tuple3('Pre-packed', constants.variantOptions['prePackedItem']!, false),
    'country':
        Tuple3('Country of origin', constants.variantOptions['country']!, true),
    'currency': Tuple3('Currency', constants.variantOptions['currency']!, true),
    'dangerous': Tuple3(
        'Dangerous class', constants.variantOptions['dangerous']!, false),
    'packingCode':
        Tuple3('Packing code', constants.variantOptions['packingCode']!, false),
  };

  @override
  AddVariantPopupState createState() => AddVariantPopupState();
}

class AddVariantPopupState extends State<AddVariantPopup> {
  AddVariantMode _selectedMode = AddVariantMode.newVariant;
  List<bool> isSelected = [true, false];
  Product? _selectedProduct;
  final Map<String, dynamic> _fieldValues = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.variant != null) {
      _selectedMode = AddVariantMode.editVariant;
      _selectedProduct = widget.variant!.product;
    }

    Map<String, dynamic> productFields = widget.variant?.product.toJson() ?? {};
    Map<String, dynamic> variantFields = widget.variant?.toJson() ?? {};

    _fieldValues['product_id'] = widget.variant?.product.id;
    _fieldValues['variant_id'] = widget.variant?.id;
    for (final field in widget.productTextFields.keys) {
      _fieldValues[field] = productFields[field];
    }

    for (final field in widget.variantTextFields.keys) {
      _fieldValues[field] = variantFields[field];
    }

    for (final field in widget.variantDropdownFields.keys) {
      _fieldValues[field] = variantFields[field];
    }
  }

  Product? buildProduct() {
    if (_selectedMode == AddVariantMode.newProduct ||
        _selectedMode == AddVariantMode.editProduct) {
      Map<String, dynamic> values = Map<String, dynamic>.from(_fieldValues);
      values['id'] = _fieldValues['product_id'];
      return Product.fromJson(values);
    }
    return _selectedProduct;
  }

  Variant? buildVariant(num? productId) {
    var product = buildProduct();
    if (product == null) {
      return null;
    }
    if (productId != null) {
      product.id = productId;
    }
    _fieldValues['isArchived'] = false;
    Map<String, dynamic> values = Map<String, dynamic>.from(_fieldValues);
    values['id'] = _fieldValues['variant_id'];
    return Variant.fromJson(values, product);
  }

  void _submitForm(context) async {
    if (!_formKey.currentState!.validate()) {
      showStandardDialog(
          context, 'Information', 'Please fill all fields appropriately');
      return;
    }

    num productId;
    if (_selectedMode == AddVariantMode.newProduct ||
        _selectedMode == AddVariantMode.editProduct) {
      var product = buildProduct();
      if (product == null) {
        showStandardDialog(
            context, 'Information', 'Could not create new product');
        return;
      }

      String errorMessage = _selectedMode == AddVariantMode.newProduct
          ? 'Could not create new product'
          : 'Could not update product';

      var productResponse = _selectedMode == AddVariantMode.newProduct
          ? await _createProduct(
              product, context.read<BrandsProvider>().currentBrand)
          : await _updateProduct(product);

      if (!responseIsOk(productResponse)) {
        showStandardDialog(context, 'Information', errorMessage);
        return;
      }

      if (_selectedMode == AddVariantMode.editProduct) {
        Navigator.of(context).pop(buildVariant(_fieldValues['product_id']));
        showStandardDialog(
            context, 'Information', 'Product updated successfully');
        Provider.of<ProductsProvider>(context, listen: false)
            .getAllProducts(force: true);
      }

      productId = _selectedMode == AddVariantMode.newProduct
          ? json.decode(productResponse.body)['id']
          : product.id;
    } else {
      if (_selectedProduct == null || _selectedProduct!.id == null) {
        showStandardDialog(context, 'Information',
            'Could not create new variant: product id is null');
        return;
      }
      productId = _selectedProduct!.id!;
    }

    var variant = buildVariant(productId);
    if (variant == null) {
      return;
    }

    if (_selectedMode != AddVariantMode.editProduct) {
      dynamic func = _selectedMode == AddVariantMode.editVariant
          ? _updateVariant
          : _createVariant;
      String successMessage = _selectedMode == AddVariantMode.editVariant
          ? 'Variant updated successfully'
          : 'Variant created successfully';
      String errorMessage = _selectedMode == AddVariantMode.editVariant
          ? 'Error update variant! Try again.'
          : 'Error creating variant! Try again.';

      performAction(context, func, variant, successMessage, errorMessage);
    }
  }

  Future<Response> _createProduct(Product product, Brand selectedBrand) async {
    return postBackendJson('products/add',
        body: product.toJson(),
        query: {'brandId': selectedBrand.id.toString()});
  }

  Future<Response> _updateProduct(Product product) {
    return putBackendJson('products/${product.id}', body: product.toJson());
  }

  Future<Response> _createVariant(Variant variant) {
    return postBackendJson('variants/add', body: variant.toJson());
  }

  Future<Response> _updateVariant(Variant variant) {
    return putBackendJson('variants/${variant.id}', body: variant.toJson());
  }

  /// Performs a function action and shows a dialog with the result
  /// It receives the element to send on the function (Product or Variant)
  void performAction(BuildContext context, dynamic function, Variant element,
      String successMsg, String errorMsg) async {
    function(element).then((Response response) => {
          if (responseIsOk(response))
            {
              Navigator.of(context)
                  .pop(buildVariant(jsonDecode(response.body)['productId'])),
              showStandardDialog(context, 'Information', successMsg),
              Provider.of<ProductsProvider>(context, listen: false)
                  .getAllProducts(force: true),
            }
          else
            {
              showStandardDialog(context, 'Information', errorMsg),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return RightPopupTitled(
      title: 'Variant Properties',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  _createModeSelection(),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  ..._createFields()
                ],
              )))),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                onPressed: () => _submitForm(context),
                child: const Text('Save'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Discard'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createModeSelection() {
    String firstBtnText = _selectedMode == AddVariantMode.editVariant ||
            _selectedMode == AddVariantMode.editProduct
        ? 'Edit variant'
        : 'Add Variant';
    String secondBtnText = _selectedMode == AddVariantMode.editVariant ||
            _selectedMode == AddVariantMode.editProduct
        ? 'Edit product'
        : 'Add Product';

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ToggleButtons(
          isSelected: isSelected,
          selectedColor: Colors.black,
          fillColor: Colors.cyan[100],
          textStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          renderBorder: true,
          borderWidth: 1.5,
          borderRadius: BorderRadius.circular(10),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(firstBtnText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(secondBtnText),
            )
          ],
          onPressed: (int newIndex) {
            setState(() {
              bool isNew = _selectedMode == AddVariantMode.newProduct ||
                  _selectedMode == AddVariantMode.newVariant;
              if (newIndex == AddVariantMode.newVariant.index) {
                _selectedMode = isNew
                    ? AddVariantMode.newVariant
                    : AddVariantMode.editVariant;
              } else {
                _selectedMode = isNew
                    ? AddVariantMode.newProduct
                    : AddVariantMode.editProduct;
              }
              isSelected = [
                isNew
                    ? _selectedMode == AddVariantMode.newVariant
                    : _selectedMode == AddVariantMode.editVariant,
                isNew
                    ? _selectedMode == AddVariantMode.newProduct
                    : _selectedMode == AddVariantMode.editProduct,
              ];
            });
          })
    ]);
  }

  List<Widget> _createFields() {
    var formWidgets = <Widget>[];

    if (_selectedMode == AddVariantMode.newProduct ||
        _selectedMode == AddVariantMode.editProduct) {
      formWidgets
          .add(const Text("Product details", style: TextStyle(fontSize: 18)));
      formWidgets
          .add(const Padding(padding: EdgeInsets.symmetric(vertical: 5)));
      for (var key in widget.productTextFields.keys) {
        var field = widget.productTextFields[key];
        formWidgets.add(_createFormField(key, field!.item1, field.item2,
            field.item3, field.item4, field.item5));
      }
    } else {
      formWidgets.add(_createProductDropdown());
    }
    formWidgets.add(const Padding(padding: EdgeInsets.symmetric(vertical: 10)));

    if (_selectedMode != AddVariantMode.editProduct ||
        _selectedMode != AddVariantMode.editProduct) {
      formWidgets
          .add(const Text("Variant details", style: TextStyle(fontSize: 18)));
      for (var key in widget.variantTextFields.keys) {
        var field = widget.variantTextFields[key];
        formWidgets.add(_createFormField(key, field!.item1, field.item2,
            field.item3, field.item4, field.item5));
      }
      for (var key in widget.variantDropdownFields.keys) {
        var field = widget.variantDropdownFields[key];
        formWidgets.add(_createDropdownButtonFormField(
            key, field!.item1, field.item2, field.item3));
      }
    }
    return formWidgets;
  }

  Widget _createProductDropdown() {
    return DropdownSearch<String>(
      selectedItem: _selectedProduct?.name,
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        showSearchBox: true,
      ),
      //selectedItem: _selectedProduct?.name,
      items: Provider.of<ProductsProvider>(context)
          .products
          .map((e) => e.name)
          .toList(),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: "Product *",
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan),
          ),
        ),
      ),
      validator: (String? item) {
        if (item == null) {
          return "Select a product";
        }
        return null;
      },
      onChanged: (String? productName) {
        setState(() {
          _selectedProduct =
              Provider.of<ProductsProvider>(context, listen: false)
                  .products
                  .firstWhere((element) => element.name == productName);
        });
      },
    );
  }

  TextFormField _createFormField(String name, String hintText, bool required,
      int? minLength, int? maxLength, bool isNumber) {
    return TextFormField(
      initialValue: _fieldValues[name]?.toString(),
      cursorColor: Colors.cyan,
      onChanged: (value) {
        if (isNumber) {
          _fieldValues[name] = double.tryParse(value) ?? int.tryParse(value);
        } else {
          _fieldValues[name] = value;
        }
      },
      decoration: InputDecoration(
        hintText: required ? '$hintText *' : hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
      ),
      keyboardType: isNumber ? TextInputType.number : null,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))]
          : null,
      validator: (value) {
        if (value == null) {
          return null;
        }
        if (required && value.isEmpty) {
          return '$hintText is required';
        }
        if (minLength != null && value.length < minLength && value.isNotEmpty) {
          return '$hintText must be at least $minLength characters';
        }
        if (maxLength != null && value.length > maxLength && value.isNotEmpty) {
          return '$hintText must be at most $maxLength characters';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField<dynamic> _createDropdownButtonFormField(
      String name, String hintText, List<dynamic> items, bool required) {
    dynamic value = _fieldValues[name];
    var itemsWithNull = [null, ...items];

    return DropdownButtonFormField<dynamic>(
      value: value,
      decoration:
          InputDecoration(hintText: required ? '$hintText *' : hintText),
      validator: (value) {
        if (required && value == null) {
          return '$hintText is required';
        }
        return null;
      },
      onChanged: (newValue) {
        setState(() {
          _fieldValues[name] = newValue;
        });
      },
      items: itemsWithNull.map<DropdownMenuItem<dynamic>>((dynamic value) {
        return DropdownMenuItem<dynamic>(
          value: value,
          child: Text(value == null
              ? required
                  ? '$hintText *'
                  : hintText
              : value.toString()),
        );
      }).toList(),
    );
  }
}
