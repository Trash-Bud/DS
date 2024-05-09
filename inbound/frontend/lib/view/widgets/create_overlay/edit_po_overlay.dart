import 'package:flutter/material.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/view/widgets/create_overlay/edit_po_form.dart';
import 'package:frontend/view/widgets/create_overlay/page_header.dart';

class EditPoOverlay extends StatelessWidget {
  const EditPoOverlay({super.key, required this.purchaseOrder});

  final PurchaseOrder purchaseOrder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [EditPoHeader(purchaseOrder: purchaseOrder), EditPoForm(purchaseOrder: purchaseOrder)],
          )),
    );
  }
}
