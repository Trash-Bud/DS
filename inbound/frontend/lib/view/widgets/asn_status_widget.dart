import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/asn_status.dart';

import 'package:frontend/model/entities/asn.dart';

class AsnStatusWidget extends StatelessWidget {
  final List<Asn> asns;

  const AsnStatusWidget({super.key, required this.asns});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
        children: getTags());
  }

  List<Widget> getTags() {
    List<Widget> tags = [];
    int cancelled = 0;
    int received = 0;
    int booked = 0;
    int pending = 0;

    for (Asn asn in asns) {
      if (asn.status == ASNStatus.received) {
        received++;
      }
      if (asn.status == ASNStatus.cancelled) {
        cancelled++;
      }
      if (asn.status == ASNStatus.booked) {
        booked++;
      }
      if (asn.status == ASNStatus.pending) {
        pending++;
      }
    }

    if (pending > 0) {
      tags.add(AsnTag(text:"($pending) ${ASNStatus.pending.toString()}",status: ASNStatus.pending));
    }
    if (booked > 0) {
      tags.add(AsnTag(text:"($booked) ${ASNStatus.booked.toString()}",status: ASNStatus.booked));
    }
    if (received > 0) {
      tags.add(AsnTag(text:"($received) ${ASNStatus.received.toString()}",status: ASNStatus.received));
    }
    if (cancelled > 0) {
      tags.add(AsnTag(text:"($cancelled) ${ASNStatus.cancelled.toString()}",status: ASNStatus.cancelled));
    }

    return tags;
  }

}

class AsnTag extends StatelessWidget{
  final String text;
  final ASNStatus status;
  const AsnTag({super.key, required this.text, required this.status});

  Widget smallTag() {
    return Tag(text: text, textColor: appVeryLightGreyColor,
        backgroundColor: ASNStatus.asnStatusColor[status]!
    );
  }
  @override
  Widget build(BuildContext context) {
    return smallTag();
  }

}