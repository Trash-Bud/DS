import 'package:flutter/material.dart';
import 'package:frontend/model/entities/asn.dart';

import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';

class NextAsnStatusSection extends StatelessWidget {
  final PurchaseOrder po;

  const NextAsnStatusSection(this.po, {super.key});

  @override
  Widget build(BuildContext context) {
    String? text;
    if ((text = conditionCheck()) != null) {
      return getTextBox(text!, context);
    }

    return FittedBox(
        // prevents data cell from overflowing
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(children: [
              getBookingRequiredSection(context),
              getShippingReference(context)
            ]),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getCheckBoxes(context),
            ),
          ],
        ));
  }

  String? conditionCheck() {
    if (po.allAsnsCancelled()) {
      return "All advance shipping notices cancelled";
    } else if (po.noCreatedAsnsExist()) {
      return "No advance shipping notices created yet";
    } else if (po.allAsnsBooked()) {
      return "All advance shipping notices booked";
    } else if (po.allAsnsReceived()) {
      return "All advance shipping notices received";
    }
    return null;
  }

  Widget getBookingRequiredSection(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Booking required",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold)),
        const Icon(Icons.error_rounded, color: Colors.orange, size: 20),
      ],
    );
  }

  List<Widget> getCheckBoxes(context) {
    Asn? nextReception = po.nextAsn();
    return [
      getCheckBox("Warehouse", nextReception?.isWarehouseChecked, context),
      getCheckBox("Planned Delivery Date", nextReception?.isReceived, context),
      getCheckBox("Stock Allocation", nextReception?.stockAllocated, context),
    ];
  }

  Widget getCheckBox(text, value, context) {
    return Row(
      children: [
        Icon(Icons.check_circle,
            color: (value) ? Colors.green : Colors.grey, size: 10),
        Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
            color: Colors.grey,
          ),
        ),
        // Circle with color mark
      ],
    );
  }

  Widget getTextBox(String text, BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            // TODO: move verification to function arg or change the Text creation
            decoration: po.status == PoStatus.cancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none));
  }

  Widget getShippingReference(context) {
    return Row(children: [
      getTextBox("ASN ${po.nextAsn()?.shippingReference}", context)
    ]);
  }
}
