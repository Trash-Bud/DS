import 'package:flutter/material.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/view/widgets/details/asn_section.dart';
import '../widgets/back_page.dart';
import '../widgets/details/asns_header.dart';
import '../widgets/details/po_details_box.dart';

class ASNDetails extends StatelessWidget {
  final Asn data;
  const ASNDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return base(context, constraints);
        },
      ),
    );
  }

  Widget base(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackPage(),
              PoDetailsBox(data:null, constraints: constraints),
              const AsnsHeader(),
              AsnSection(asns: [data], constraints: constraints)
            ]),
      ),
    );
  }
}
