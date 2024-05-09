import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/model/entities/product.dart';
import 'package:frontend/model/page_state.dart';
import 'package:provider/provider.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/view/widgets/asn_status_widget.dart';
import 'package:frontend/view/widgets/asn_card/more_options_button_asn.dart';

Future<void> _downloadAsnInfo(context, Asn asn) async {
  final model = Provider.of<AsnChangeNotifier>(context, listen: false);
  await model.downloadAsnFile(asn.id);

  if (model.mainPageState == PageState.error) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarError(
        context, "Failed to download ASN: ${model.errorMessage}"));
  }
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBarLoaded(context, "Successfully downloaded ASN"));
}

class AsnSection extends StatefulWidget {
  final List<Asn> asns;
  final BoxConstraints constraints;
  final int currentSelectedIndex;

  const AsnSection(
      {super.key,
      required this.asns,
      required this.constraints,
      this.currentSelectedIndex = 0});

  @override
  State<StatefulWidget> createState() {
    return _AsnSection();
  }
}

class _AsnSection extends State<AsnSection> {
  Asn? currentASN;

  @override
  void initState() {
    super.initState();
    var poModel = context.read<AsnChangeNotifier>();
    poModel.addListener(listener);
    setState(() {
      if (widget.asns.isNotEmpty) {
        currentASN = widget.asns[widget.currentSelectedIndex];
      }
    });
  }

  void listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.constraints.maxWidth < smallWidth
        ? asnListSmall(context, widget.constraints)
        : asnListBig(context, widget.constraints);
  }

  Widget asnListSmall(context, BoxConstraints constraints) {
    return Column(children: getAsnCards(context, constraints));
  }

  Widget asnListBig(BuildContext context, BoxConstraints constraints) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Column(children: getAsnCards(context, constraints)),
      ),
      if (currentASN != null)
        Expanded(
            child: Column(children: [
          asnInfo(context, constraints),
          itemsInformation(context, constraints)
        ]))
      //if (currentASN != null) Expanded(child: asnInfo(context, constraints))
    ]);
  }

  List<Widget> getAsnCards(context, BoxConstraints constraints) {
    List<Widget> list = [];
    for (var asn in widget.asns) {
      list.add(asnCard(asn, constraints));
      if (asn == currentASN) {
        if (constraints.maxWidth < smallWidth) {
          list.add(asnInfo(context, constraints));
          list.add(itemsInformation(context, constraints));
        }
      }
    }
    return list;
  }

  onASNPressed(Asn asn){
    setState(() {
      currentASN = asn;
    });
  }

  Widget asnCard(Asn asn, BoxConstraints constraints) {
    return MenuTab(
      key: Key("ASN_Card_${asn.id}"),
      text: asn.shippingReference,
      selected: asn == currentASN,
      onPressed: () => onASNPressed(asn),
      right: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            AsnTag(text: asn.status.toString(), status: asn.status),
            if (asn == currentASN) MoreOptionsButton(asn)
          ],
        ),
      ),
    );
  }

  Widget asnInfo(context, BoxConstraints constraints) {
    return Column(
      children: [asnInfoBox(context, constraints, generalInfo)],
    );
  }

  Widget asnInfoBox(context, BoxConstraints constraints,
      Function(BuildContext, BoxConstraints) content) {
    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20.0),
        margin: EdgeInsets.fromLTRB(
            constraints.maxWidth > smallWidth ? 10.0 : 0,
            5,
            0,
            constraints.maxWidth > smallWidth ? 0 : 5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: content(context, constraints));
  }

  Widget generalInfo(BuildContext context, BoxConstraints constraints) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ASN ${currentASN?.shippingReference} Information\n",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        Text("Warehouse: ${generalInfoText(currentASN?.warehouse)}"),
        Text("Delivery Date: ${generalInfoText(currentASN?.deliveryDate)}"),
        Text("Carrier: ${generalInfoText(currentASN?.carrier)}"),
        Text(
            "Shipper Contract: ${generalInfoText(currentASN?.shipperContact)}"),
        Text(
            "Purchase Order Date: ${generalInfoText(currentASN?.purchaseOrderDate)}"),
        Text("Status: ${currentASN?.status.toString()}")
      ],
    );
  }

  String generalInfoText(dynamic data) {
    return (data == null) ? "To be defined" : data.toString();
  }

  Widget expectedItemsCard(context, constraints) {
    int expectedItemsCount = 0;

    if (currentASN?.productList != null) {
      for (Product product in currentASN!.productList!) {
        expectedItemsCount += product.quantity!;
      }
    }

    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(Icons.local_offer))
                ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Expected Items"),
                      Text(
                          "${(currentASN?.productList == null) ? "Error" : expectedItemsCount}",
                          style: const TextStyle(fontSize: 25))
                    ]))
          ],
        ));
  }

  Widget skusCard(context, constraints) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(Icons.qr_code))
                ])),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("SKUs"),
                      Text(
                          "${(currentASN!.productList == null) ? "Error" : currentASN!.productList!.length}",
                          style: const TextStyle(fontSize: 25))
                    ]))
          ],
        ));
  }

  Future<void> onPressedDownload() async {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBarLoading(context));
    _downloadAsnInfo(context, currentASN!);
  }

  Widget itemsInformation(context, BoxConstraints constraints) {
    List<Widget> columnChildren = [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text("Items Information\n",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold))),
          TextButton(
              onPressed: () => onPressedDownload(),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(appPrimaryColor)
              ),
              child: Row(
                children: const [
                  Text("Export items details (.xlsx)"),
                  Icon(Icons.download, size: 20)
                ],
              ))
        ],
      )
    ];

    if (constraints.maxWidth < smallWidth) {
      columnChildren.add(expectedItemsCard(context, constraints));
      columnChildren.add(skusCard(context, constraints));
    } else {
      columnChildren.add(Row(children: [
        Expanded(child: expectedItemsCard(context, constraints)),
        Expanded(child: skusCard(context, constraints)),
      ]));
    }

    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20.0),
        margin: EdgeInsets.fromLTRB(
            constraints.maxWidth > smallWidth ? 10.0 : 0,
            5,
            0,
            constraints.maxWidth > smallWidth ? 0 : 5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnChildren));
  }
}
