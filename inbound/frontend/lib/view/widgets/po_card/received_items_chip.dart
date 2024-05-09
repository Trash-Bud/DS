import 'package:flutter/material.dart';

import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/view/widgets/po_card/po_card.dart';


class ReceivedItemsChip extends StatelessWidget {
  static List<Set<Color>> colors = [
    // text color, background color
    {
      const Color.fromRGBO(115, 115, 185, 1),
      const Color.fromRGBO(240, 240, 247, 0.7)
    }, // purple
    {
      const Color.fromRGBO(169, 152, 119, 1),
      const Color.fromRGBO(245, 237, 221, 0.7)
    }, //  yellow
    {
      const Color.fromRGBO(114, 146, 101, 1),
      const Color.fromRGBO(207, 224, 200, 0.7)
    }, // green, // purple
  ];

  final PurchaseOrder po;

  const ReceivedItemsChip(this.po, {super.key});

  @override
  Widget build(BuildContext context) {
    num percentage = po.totalItems != 0
        ? ((po.receivedItems / po.totalItems) * 100).round()
        : 0;
    Set<Color> color = colors[percentage ~/ 33];
    return Chip(
        backgroundColor: color.elementAt(1),
        label: Text(
            style: TextStyle(
              color: color.elementAt(0),
              decoration: PurchaseOrderCard.strikethroughText(po),
              fontWeight: FontWeight.bold,
            ),
            "$percentage%"));
  }


}