import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/po_card/po_card_small.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/view/widgets/table_and_lists/small_list.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';

import 'package:frontend/model/po_status.dart';

class PoListSmall extends StatelessWidget {
  final List<PurchaseOrder> purchaseOrders;

  const PoListSmall(this.purchaseOrders, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListSmall(
        colorCaption: ColorCaption(
          PoStatus.poStatusColor.map((key, value) => MapEntry(key.toString(), value)),
        ),
        card: getCard,
        paginationInfo:
            Provider.of<PurchaseOrderChangeNotifier>(context, listen: false)
                .paginationInfo, itemCount: purchaseOrders.length,);
  }

  Widget getCard(int index, BuildContext context) {
    final po = purchaseOrders[index];
    return PoCardSmall(po);
  }
}
