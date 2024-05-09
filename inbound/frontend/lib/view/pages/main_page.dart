import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/model/page_state.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/view/widgets/asn_list/asn_list_big.dart';
import 'package:frontend/view/widgets/asn_list/asn_list_small.dart';
import 'package:frontend/view/widgets/asn_list_navbar/asn_nav_bar.dart';
import 'package:frontend/view/widgets/po_list/po_list_big.dart';
import 'package:frontend/view/widgets/po_list/po_list_small.dart';
import 'package:frontend/view/widgets/po_list_navbar/po_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:design_system/design_system.dart';

class PoPage extends StatefulWidget {
  final int index;
  const PoPage({super.key, this.index = 0});

  @override
  State<StatefulWidget> createState() {
    return _PoPage();
  }
}

class _PoPage extends State<PoPage> {
  List<PurchaseOrder> purchaseOrders = [];
  List<Asn> asns = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.index,
      child: Scaffold(
          appBar: AppTabBar(
            tabs: const [
              Tab(icon: Icon(Icons.storefront), text: "POs"),
              Tab(
                icon: Icon(Icons.list_alt),
                text: "ASNs",
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final poModel = Provider.of<PurchaseOrderChangeNotifier>(context);
              final asnModel = Provider.of<AsnChangeNotifier>(context);
              if (poModel.mainPageState == PageState.loading || asnModel.mainPageState == PageState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (poModel.mainPageState == PageState.error) {
                return Center(
                    child:
                        Text("An error has occurred: ${poModel.errorMessage}"));
              }
              if (asnModel.mainPageState == PageState.error) {
                return Center(
                    child: Text("An error has occurred: ${asnModel.errorMessage}"));
              }
              purchaseOrders =  poModel.purchaseOrders;
              asns = asnModel.asns;

              return TabBarView(children: [
                basePoPage(constraints, context),
                baseAsnPage(constraints, context),
              ]);
            },
          )),
    );
  }


  Widget basePoPage(BoxConstraints constraints, BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PoNavBar(),
          (constraints.maxWidth < smallWidth
              ? Flexible(child: PoListSmall(purchaseOrders))
              : Flexible(child: PoListBig(purchaseOrders))),
        ]);
  }

  void refresh() async {

    final asnsContext =
    Provider.of<AsnChangeNotifier>(context, listen: false);
    await asnsContext.fetchAsns();

    setState(() {
      asns = asnsContext.asns;
    });
  }

  Widget baseAsnPage(BoxConstraints constraints, BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ASNNavBar(notifyParent: refresh),
          constraints.maxWidth < smallWidth
              ? Flexible(child: ASNListSmall(asns))
              : Flexible(child: ASNListBig(asns)),
        ]);
  }
}
