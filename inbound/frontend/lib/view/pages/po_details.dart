import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/model/page_state.dart';
import 'package:frontend/view/widgets/create_overlay/create_asn_overlay.dart';
import 'package:provider/provider.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/view/widgets/back_page.dart';
import 'package:frontend/view/widgets/details/asn_section.dart';
import 'package:frontend/view/widgets/details/asns_header.dart';
import 'package:frontend/view/widgets/details/po_details_box.dart';

Future<void> _downloadAsnInfo(context, PurchaseOrder po) async {
  final model =
      Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
  await model.downloadPurchaseOrderFile(po.id);

  if (model.mainPageRequestSate == PageState.error) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarError(
        context, "Failed to download ASN: ${model.errorMessage}"));
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBarLoaded(context, "Successfully downloaded ASN"));
}

class PoDetails extends StatefulWidget {
  final PurchaseOrder data;
  final int index;

  const PoDetails({super.key, required this.data, this.index = 0});

  @override
  State<StatefulWidget> createState() {
    return _PoDetails();
  }
}

class _PoDetails extends State<PoDetails> {
  PurchaseOrder? data;

  PurchaseOrder getData() {
    return data != null ? data! : widget.data;
  }

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

  List<Widget> headerAndDownload(
      BuildContext context, BoxConstraints constraints) {
    return constraints.maxWidth < smallWidth
        ? [const AsnsHeader(), downloadPoButton(context)]
        : [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [const AsnsHeader(), downloadPoButton(context)])
          ];
  }

  Widget base(BuildContext context, BoxConstraints constraints) {
    List<Widget> contentList = [];
    contentList.add(const BackPage());
    contentList.add(header(context, constraints));
    contentList.add(PoDetailsBox(data: getData(), constraints: constraints));
    contentList.addAll(headerAndDownload(context, constraints));
    contentList.add(AsnSection(
        asns: getData().asns,
        constraints: constraints,
        currentSelectedIndex: widget.index));

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: contentList),
      ),
    );
  }

  Future<void> onPressedDownload(context) async {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
    _downloadAsnInfo(context, getData());
  }

  Widget downloadPoButton(context) {
    return TextButton(
        onPressed: () => onPressedDownload(context),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(appPrimaryColor)),
        child: Row(
          children: const [
            Text("Export purchase order details (.xlsx)"),
            Icon(Icons.download, size: 20)
          ],
        ));
  }

  void refresh() async {
    final poContext =
        Provider.of<PurchaseOrderChangeNotifier>(context, listen: false);
    var po = await poContext.getPurchaseOrderById(getData().id);
    setState(() {
      if (po != null) data = po;
    });
  }

  Widget header(BuildContext context, BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              getData().name,
              style: getData().status == PoStatus.cancelled
                  ? Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(decoration: TextDecoration.lineThrough)
                  : Theme.of(context).textTheme.headline3,
            ),
          ),
          (isSmallScreen(context))
              ? PrimaryIconButton(
                  icon: Icons.add,
                  onPressed: () => onCreateASNPressed(context),
                  width: 100)
              : PrimaryButton(
                  title: "Create ASN",
                  onPressed: () => onCreateASNPressed(context),
                  width: 200),
        ],
      ),
    );
  }

  onCreateASNPressed(BuildContext context) => TitledOverlay.showTitledOverlay(
      context,
      "Create ASN",
      CreateAsnOverlay(
        purchaseOrder: data,
        notifyParent: () => refresh,
      ));

  ButtonStyle? getStyle(context, BoxConstraints constraints) {
    return (isSmallScreen(context))
        ? ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ))
        : Theme.of(context).elevatedButtonTheme.style;
  }
}
