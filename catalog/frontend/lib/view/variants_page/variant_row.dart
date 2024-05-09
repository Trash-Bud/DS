import 'package:flutter/material.dart';
import 'package:frontend/controller/network.dart';
import 'package:frontend/controller/providers/products_provider.dart';
import 'package:frontend/model/variant.dart';
import 'package:frontend/view/common/utils.dart';
import 'package:frontend/view/variant_view_popup.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class VariantRow extends StatefulWidget {
  final Variant variant;
  final int pageNumber;

  const VariantRow(
      {super.key, required this.variant, required this.pageNumber});

  @override
  State<StatefulWidget> createState() => VariantRowState();
}

class VariantRowState extends State<VariantRow> {
  bool _isHoveringRow = false;
  bool _isHoveringArchiveButton = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: MouseRegion(
            onHover: (event) {
              if (!_isHoveringRow) {
                setState(() {
                  _isHoveringRow = true;
                });
              }
            },
            onExit: (event) {
              if (_isHoveringRow) {
                setState(() {
                  _isHoveringRow = false;
                });
              }
            },
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return VariantViewPopup(variant: widget.variant);
                      });
                },
                child: Container(
                    color: _isHoveringRow ? Colors.cyan[50] : Colors.white,
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: Row(children: [
                      Flexible(
                          child: SizedBox(
                              width: 350,
                              child: Text(widget.variant.product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)))),
                      ...[
                        widget.variant.product.supplier,
                        widget.variant.product.type,
                        widget.variant.product.family,
                        widget.variant.variantDescription
                      ]
                          .map((text) => Flexible(
                              child: SizedBox(
                                  width: 350, child: Text(text.toString()))))
                          .toList(),
                      SizedBox(
                          width: 50,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MouseRegion(
                                    onHover: (event) {
                                      if (_isHoveringArchiveButton) {
                                        setState(() {
                                          _isHoveringArchiveButton = false;
                                        });
                                      }
                                    },
                                    onExit: (event) {
                                      if (!_isHoveringArchiveButton) {
                                        setState(() {
                                          _isHoveringArchiveButton = false;
                                        });
                                      }
                                    },
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                        child: IconButton(
                                      onPressed: () async => {
                                        if (await showStandardDialog(
                                            context,
                                            'Confirmation',
                                            'Do you want to archive the selected variant?',
                                            yesMessage: 'Archive',
                                            noMessage: 'Keep'))
                                          _archiveVariant(context,
                                              widget.variant, widget.pageNumber)
                                      },
                                      icon: _isHoveringArchiveButton
                                          ? const Icon(Icons.delete,
                                              color: Colors.cyan)
                                          : const Icon(Icons.delete_outline,
                                              color: Colors.cyan),
                                      alignment: AlignmentDirectional.centerEnd,
                                      iconSize: 18,
                                    )))
                              ]))
                    ])))));
  }

  void _archiveVariant(
      BuildContext context, Variant variant, int pageNumber) async {
    variant.isArchived = true;
    _archiveVariantPost(variant.id, variant.isArchived).then((response) {
      if (responseIsOk(response)) {
        showStandardDialog(
            context, 'Information', 'Variant archived successfully!');
        Provider.of<ProductsProvider>(context, listen: false)
            .getNumberOfVariantPages();
        Provider.of<ProductsProvider>(context, listen: false)
            .getVariants(pageNumber: pageNumber, force: true);
      } else {
        showStandardDialog(
            context, 'Information', 'Error archiving variant! Try again.');
        variant.isArchived = false;
      }
    });
  }

  Future<Response> _archiveVariantPost(num? id, bool isArchived) {
    return postBackendJson('variants/archive/$id',
        body: {'isArchived': isArchived});
  }
}
