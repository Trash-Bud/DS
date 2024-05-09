import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/po_card/po_card.dart';
import 'package:frontend/view/widgets/po_card/received_items_chip.dart';
import 'package:frontend/model/entities/purchase_order.dart';

class ReceivedItemsSection extends StatelessWidget {
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
  final BuildContext context;

  const ReceivedItemsSection(this.po, this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [getPoPercentage(context), getPoItems()],
      ),
    );
  }

  getPoItems() {
    return Text("${po.receivedItems}/${po.totalItems}",
              style: TextStyle(
                decoration: PurchaseOrderCard.strikethroughText(po),
                fontWeight: FontWeight.normal,
              ));
  }

  getPoPercentage(context) {
    return ReceivedItemsChip(po);
  }
}
