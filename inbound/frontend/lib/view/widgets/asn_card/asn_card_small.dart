import 'package:flutter/material.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/view/widgets/asn_card/asn_card.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/view/widgets/asn_card/more_options_button_asn.dart';
import 'package:frontend/view/widgets/asn_card/utils.dart';


class ASNCardSmall extends StatelessWidget {
  final Asn asn;

  const ASNCardSmall(this.asn, {super.key});

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
          onTap: () => navigateToDetails(context, asn),
          child: ClipPath(
            clipper: getShapeBorderClipper(),
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            color: ASNStatus.asnStatusColor[asn.status]!,
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
            flex: 4,
            child: FittedBox(
                fit: BoxFit.fill,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getCardChildren(context))),
          ),
          Flexible(
            flex: 1,
            child: Column(children: <Widget>[
              MoreOptionsButton(asn)
            ]),
          )
        ]);
  }

  List<Widget> getCardChildren(BuildContext context) {
    return <Widget>[
      Row(children: [
        Text(
          asn.shippingReference,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            decoration: ASNCard.strikethroughText(asn),
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
          asn.warehouse == null ? "No Warehouse" : asn.warehouse!,
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            decoration: ASNCard.strikethroughText(asn),
            color: Colors.grey,
          ),
          textAlign: TextAlign.left,
        )
      ]),
      Row(children: [
        Text(
            asn.deliveryDate == null ? "No Delivery Date" : asn.deliveryDate.toString(),
            overflow: TextOverflow.clip,
            softWrap: false,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              decoration: ASNCard.strikethroughText(asn),
            )),
      ]),
      Row(children: [
        Text(
            asn.poName ?? "No PO associated",
            overflow: TextOverflow.clip,
            softWrap: false,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              decoration: ASNCard.strikethroughText(asn),
            )),
      ]),
    ];
  }
}
