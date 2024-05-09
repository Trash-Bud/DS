import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/po_card/po_info_section.dart';
import 'package:frontend/view/widgets/po_card/received_items_section.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'more_options_button_po.dart';
import 'next_reception_status_section.dart';

class PurchaseOrderCard {
  final PurchaseOrder po;

  PurchaseOrderCard(this.po);

  List<Widget> build(BuildContext context) {
    return getDataCells(context);
  }

  List<Widget> getDataCells(context) {
    return [
      PoInfoSection(po, context, key: Key("poInfoSection${po.id}")),
      getSupplierSection(context),
      ReceivedItemsSection(po, context,
          key: Key("receivedItemsSection${po.id}")),
      getClosedAsnsSection(context),
      NextAsnStatusSection(po,
          key: Key("nextAsnsStatusSection${po.id}")),
      MoreOptionsButton(po, key: Key("moreOptionsButton${po.id}")),
    ];
  }

  Widget getSupplierSection(context) {
    return Text(
        key: Key("supplierName${po.id}"),
        textAlign: TextAlign.start,
        po.supplier,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: po.status == PoStatus.cancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none));
  }

  Widget getClosedAsnsSection(context) {
    return Text(
        key: Key("closedAsns${po.id}"),
        textAlign: TextAlign.start,
        "${po.closedAsns()}/${po.getAsnsNumber()}",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: po.status == PoStatus.cancelled
                ? TextDecoration.lineThrough
                : TextDecoration.none)); // TODO :add theme
  }


  static TextDecoration strikethroughText(po) {
    return (po.status == PoStatus.cancelled)
        ? TextDecoration.lineThrough
        : TextDecoration.none;
  }
}
