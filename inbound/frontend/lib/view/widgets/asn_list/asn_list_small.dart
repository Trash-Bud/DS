import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/asn_card/asn_card_small.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/view/widgets/table_and_lists/small_list.dart';
import 'package:provider/provider.dart';

import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/model/asn_status.dart';

class ASNListSmall extends StatelessWidget {
  final List<Asn> asns;

  const ASNListSmall(this.asns, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomListSmall(
        colorCaption: ColorCaption(
          ASNStatus.asnStatusColor.map((key, value) => MapEntry(key.toString(), value)),
        ),
        card: getCard,
        paginationInfo: Provider.of<AsnChangeNotifier>(context, listen: false)
            .paginationInfo,
        itemCount: asns.length);
  }

  Widget getCard(int index, BuildContext context) {
    final asn = asns[index];
    return ASNCardSmall(asn);
  }
}
