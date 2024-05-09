import 'package:flutter/material.dart';
import 'package:frontend/model/entities/asn.dart';

import 'package:frontend/model/asn_status.dart';
import 'package:frontend/view/widgets/asn_card/asn_card.dart';

class ASNInfoSection extends StatelessWidget {
  final Asn asn;
  final BuildContext context;

  const ASNInfoSection(this.asn, this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        direction: Axis.vertical,
        spacing: MediaQuery.of(context).size.height * 0.01,
        children: [
          getASNNameRow(),
          getPoStatusRow()
        ]);
  }

  getPoStatusRow() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      // Switch to Row or Flexible if more appropriate
      direction: Axis.horizontal,
      children: <Widget>[
        getASNStatusChip(),
        const SizedBox(width: 5),
        getASNIdText()
      ],
    );
  }

  getASNIdText() {
    return Text(
      key: Key('ASNIdText${asn.shippingReference}'),
      "ASN ${asn.shippingReference}",
      style: TextStyle(
        decoration: asn.status == ASNStatus.cancelled
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        color: Colors.grey,
      ),
    );
  }

  getASNStatusChip() {
    return Chip(
        backgroundColor: ASNStatus.asnStatusColor[asn.status],
        label: Text(
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.normal, color: Colors.white),
            asn.status.toString()));
  }

  getASNNameRow() {
    return Text(
        key: Key('ASNNameText${asn.shippingReference}'),
        textAlign: TextAlign.left,
        asn.shippingReference,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: ASNCard.strikethroughText(asn)));
  }
}
