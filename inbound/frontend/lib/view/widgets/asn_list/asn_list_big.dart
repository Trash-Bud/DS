import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/view/widgets/asn_card/asn_card.dart';
import 'package:frontend/view/widgets/table_and_lists/data_table.dart';
import 'package:provider/provider.dart';
import 'package:frontend/view/widgets/asn_card/utils.dart';

class ASNListBig extends StatelessWidget {
  final List<Asn> asns;
  final List<String> headers = [
    "ASN Name",
    "Warehouse",
    "Delivery Date",
    "Carrier",
    "Cargo Type",
    "Purchase Order",
    ""
  ];

  ASNListBig(this.asns, {super.key});

  @override
  Widget build(BuildContext context) {
    if (asns.isEmpty) return getEmptyList(context);
    return CustomDataTable(
      onRowTap: (int index) {
          navigateToDetails(context, asns[index]);
      },
      headers: headers,
      rows: getRows(context, 0, 10),
      paginationInfo: Provider.of<AsnChangeNotifier>(context, listen: false).paginationInfo,
    );
  }

  Widget getEmptyList(context) {
    return Center(
        child: Text(
      "No ASNs found",
      style: Theme.of(context).textTheme.headline2,
    ));
  }

  List<List<Widget>> getRows(context, int offset, int limit)  {
    return asns.map((asn) {
      return ASNCard(asn).build(context);
    }).toList();
  }
}
