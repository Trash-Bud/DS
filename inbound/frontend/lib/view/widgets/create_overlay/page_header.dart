import 'package:flutter/material.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/utils/theme.dart';

class CreatePoHeader extends StatelessWidget {

  const CreatePoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: Color(0xffF1F3F5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
                "Create Purchase Order",
                style:
                (isSmallScreen(context)) ?
                Theme
                    .of(context)
                    .textTheme
                    .headline6 :
                Theme
                    .of(context)
                    .textTheme
                    .headline5,
              )),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class EditPoHeader extends StatelessWidget {

  const EditPoHeader({super.key, required this.purchaseOrder});

  final PurchaseOrder purchaseOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: Color(0xffF1F3F5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
                "Edit Purchase Order ${purchaseOrder.poIdentification}",
                style:
                (isSmallScreen(context)) ?
                Theme
                    .of(context)
                    .textTheme
                    .headline6 :
                Theme
                    .of(context)
                    .textTheme
                    .headline5,
              )),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class EditAsnHeader extends StatelessWidget {

  const EditAsnHeader({super.key, required this.asn});

  final Asn asn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3.0, color: Color(0xffF1F3F5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
                "Edit ASN ${asn.shippingReference}",
                style:
                (isSmallScreen(context)) ?
                Theme
                    .of(context)
                    .textTheme
                    .headline6 :
                Theme
                    .of(context)
                    .textTheme
                    .headline5,
              )),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}