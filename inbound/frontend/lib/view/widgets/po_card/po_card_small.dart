import 'package:flutter/material.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/view/widgets/po_card/po_card.dart';
import 'package:frontend/view/widgets/po_card/received_items_chip.dart';
import 'package:frontend/model/po_status.dart';
import 'more_options_button_po.dart';

class PoCardSmall extends StatelessWidget {
  final PurchaseOrder po;

  const PoCardSmall(this.po, {super.key});

  @override
  Widget build(BuildContext context) {
    return getCard(context);
  }

  ShapeBorderClipper getShapeBorderClipper() {
    return ShapeBorderClipper(
        textDirection: TextDirection.ltr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
  }

  Widget getCard(context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/purchase-order", arguments: po);
          },
          child: ClipPath(
            clipper: getShapeBorderClipper(),
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            color: PoStatus.poStatusColor[po.status]!,
                            width: MediaQuery.of(context).size.width * 0.03))),
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                alignment: Alignment.center,
                child: getCardContent(context)),
          ),
        ));
  }

  Widget getCardContent(context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: FittedBox(
                fit: BoxFit.fill,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getCardChildren(context))),
          ),
          Flexible(
            flex: 1,
            child: Column(children: <Widget>[
              ReceivedItemsChip(po),
              MoreOptionsButton(po)
            ]),
          )
        ]);
  }

  List<Widget> getCardChildren(BuildContext context) {
    return <Widget>[
      Row(children: [
        Text(
          po.name,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                decoration: PurchaseOrderCard.strikethroughText(po),
              ),
          maxLines: 1,
          softWrap: false,
          textAlign: TextAlign.left,
          overflow: TextOverflow.fade,
        )
      ]),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      Row(children: [
        Text(
          po.poIdentification,
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                decoration: PurchaseOrderCard.strikethroughText(po),
                color: Colors.grey,
              ),
          textAlign: TextAlign.left,
        )
      ]),
      Row(children: [
        Text("From: ${po.supplier}",
            overflow: TextOverflow.clip,
            softWrap: false,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  decoration: PurchaseOrderCard.strikethroughText(po),
                )),
      ]),
    ];
  }
}
