import 'package:flutter/material.dart';
import 'package:frontend/model/variant.dart';
import 'package:frontend/view/add_variant_popup.dart';
import 'package:frontend/view/common/right_popup_titled.dart';

// TODO: find a way to make this work
// ignore: must_be_immutable
class VariantViewPopup extends StatefulWidget {
  VariantViewPopup({super.key, required this.variant});

  Variant variant;

  @override
  VariantViewPopupState createState() => VariantViewPopupState();
}

class VariantViewPopupState extends State<VariantViewPopup> {
  VariantViewPopupState();

  @override
  Widget build(BuildContext context) {
    return RightPopupTitled(title: 'Variant Properties', child: body(context));
  }

  Widget body(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _variantTitle(),
          _variantProperties(),
          _editButton(context),
        ],
      );

  Widget _variantTitle() => Text(
        widget.variant.product.name,
        style: const TextStyle(fontSize: 18),
      );

  Widget _variantProperties() {
    final controller = ScrollController();
    return Expanded(
        child: Scrollbar(
      controller: controller,
      thumbVisibility: true,
      child: ListView(
        controller: controller,
        children: [
          // Product details
          _variantProperty('Name', widget.variant.product.name),
          _variantProperty('Description', widget.variant.product.description),
          _variantProperty('Season', widget.variant.product.season),
          _variantProperty('Supplier', widget.variant.product.supplier),
          _variantProperty('Type', widget.variant.product.type),
          _variantProperty('Family', widget.variant.product.family),
          _variantProperty('Subfamily', widget.variant.product.subfamily),
          // Variant details
          _variantProperty('SKU', widget.variant.sku),
          _variantProperty('Barcode', widget.variant.barcode),
          _variantProperty('Pre-packed item', widget.variant.prePackedItem),
          _variantProperty(
              'Variant Description', widget.variant.variantDescription),
          _variantProperty('Composition', widget.variant.composition),
          _variantProperty('HS code', widget.variant.hscode),
          _variantProperty('Country of Origin', widget.variant.country),
          _variantProperty('Gender', widget.variant.gender),
          _variantProperty('Age Group', widget.variant.ageGroup),
          _variantProperty('Color', widget.variant.color),
          _variantProperty('Size', widget.variant.size),
          _variantProperty('Fabric', widget.variant.fabric),
          _variantProperty('Width', widget.variant.width),
          _variantProperty('Height', widget.variant.height),
          _variantProperty('Depth', widget.variant.depth),
          _variantProperty('Weight', widget.variant.weight),
          _variantProperty('Price B2B', widget.variant.priceRetail),
          _variantProperty('Price B2C', widget.variant.priceWholesale),
          _variantProperty('Cost', widget.variant.cost),
          _variantProperty('Currency', widget.variant.currency),
          _variantProperty('Dangerous Class', widget.variant.dangerous),
          _variantProperty('Un Number', widget.variant.unNumber),
          _variantProperty('Packaging Code', widget.variant.packingCode)
        ],
      ),
    ));
  }

  _variantProperty(String propName, prop) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              width: 200,
              child: Text(
                "$propName:",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                color: const Color.fromRGBO(217, 217, 217, 1),
                child: Text(
                  prop == null ? '' : prop.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _editButton(BuildContext context) => Container(
        height: 35,
        width: 200,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Colors.cyan,
          ),
          onPressed: () {
            showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddVariantPopup(
                        variant: widget.variant,
                      );
                    })
                .then((value) =>
                    value != null ? _setVariant(value as Variant) : '');
          },
          child: const Text('Edit Variant'),
        ),
      );

  void _setVariant(Variant newVariant) {
    setState(() {
      widget.variant = newVariant;
    });
  }
}
