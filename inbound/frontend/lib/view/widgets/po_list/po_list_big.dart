import 'package:flutter/material.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/view/widgets/po_card/po_card.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/view/widgets/table_and_lists/data_table.dart';

class PoListBig extends StatelessWidget {
  late final List<PurchaseOrder> pos;
  final List<String> headers = [
    "PO Number",
    "Supplier",
    "Received",
    "Closed",
    "Next ASN Status",
    ""
  ];

  PoListBig(this.pos, {super.key});

  @override
  Widget build(BuildContext context) {
    if (pos.isEmpty) return getEmptyList(context);
    return CustomDataTable(
      onRowTap: (int index) {
        Navigator.pushNamed(context, "/purchase-order", arguments: pos[index]);
      },
      headers: headers,
      rows: getInitialRows(context),
      paginationInfo: Provider.of<PurchaseOrderChangeNotifier>(context, listen: false).paginationInfo,
    );
  }


  Widget getEmptyList(context) {
    return Center(
        child: Text(
      "No purchase orders found",
      style: Theme.of(context).textTheme.headline2,
    ));
  }

  List<List<Widget>> getInitialRows(context) {
    return pos.map((po) => PurchaseOrderCard(po).build(context)).toList();
  }
}
