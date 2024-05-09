import 'package:flutter/material.dart';
import 'package:frontend/model/entities/purchase_order.dart';

import 'package:frontend/model/po_status.dart';
import 'package:frontend/view/widgets/po_card/po_card.dart';

class PoInfoSection extends StatelessWidget {
  final PurchaseOrder po;
  final BuildContext context;

  const PoInfoSection(this.po, this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        direction: Axis.vertical,
        spacing: MediaQuery.of(context).size.height * 0.01,
        children: [
          getPoNameRow(),
          getPoStatusRow()
        ]);
  }

  getPoStatusRow() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      // Switch to Row or Flexible if more appropriate
      direction: Axis.horizontal,
      children: <Widget>[
        getPoStatusChip(),
        const SizedBox(width: 5),
        getPoIdText()
      ],
    );
  }

  getPoIdText() {
    return Text(
      key: Key('poIdText${po.id}'),
      po.poIdentification,
      style: TextStyle(
        decoration: po.status == PoStatus.cancelled
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        color: Colors.grey,
      ),
    );
  }

  getPoStatusChip() {
    return Chip(
        backgroundColor: PoStatus.poStatusColor[po.status],
        label: Text(
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.normal, color: Colors.white),
            po.status.toString()));
  }

  getPoNameRow() {
    return Text(
      key: Key('poNameText${po.id}'),
        textAlign: TextAlign.left,
        po.name,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: PurchaseOrderCard.strikethroughText(po)));
  }
}
