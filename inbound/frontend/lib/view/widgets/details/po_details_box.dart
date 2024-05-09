
import 'package:flutter/material.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/purchase_order_change_notifier.dart';
import '../../../utils/theme.dart';
import '../asn_status_widget.dart';
import '../po_cancelled_strike_text.dart';
import '../po_status_widget.dart';

class PoDetailsBox extends StatefulWidget{
  final PurchaseOrder? data;
  final BoxConstraints constraints;

  const PoDetailsBox({super.key, this.data, required this.constraints});

  @override
  State<StatefulWidget> createState() {
    return _PoDetailsBox();
  }
}

class _PoDetailsBox extends State<PoDetailsBox>{

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
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
        child: widget.data is PurchaseOrder ? poDetails(context) : noPoDetails(context));
  }

  @override
  void initState() {
    super.initState();
    var poModel = context.read<PurchaseOrderChangeNotifier>();
    poModel.addListener(listener);
  }



  void listener(){
    setState(() {
    });
  }


  Widget noPoDetails(BuildContext context){
    return Center(child: Text("No purchase order associated.", style: Theme.of(context).textTheme.headlineMedium,));
  }

  Widget poDetails(BuildContext context) {
    return widget.constraints.maxWidth < smallWidth
        ? detailsBoxSmall(context)
        : detailsBoxBig(context);
  }

  Widget detailsBoxSmall(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          poName(context),
          const SizedBox(
            height: 15,
          ),
          infoColumn("Purchase Order Status", PoStatusWidget(po: widget.data), context),
          const SizedBox(
            height: 15,
          ),
          infoColumn("Received", percentageInfo(context), context),
          const SizedBox(
            height: 15,
          ),
          infoColumn(
              "Advanced Shipping Notices (${widget.data?.getAsnsNumber()})",
              getASNInfo(), context),
        ]);
  }

  Widget detailsBoxBig(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        poName(context),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoColumn(
                  "Purchase Order Status", PoStatusWidget(po: widget.data), context),
              infoColumn("Received", percentageInfo(context), context),
              infoColumn(
                  "Advanced Shipping Notices (${widget.data?.getAsnsNumber()})",
                  getASNInfo(), context),
            ],
          ),
        ),
      ],
    );
  }

  Widget poName(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PoText(
              text: widget.data!.supplier,
              data: widget.data,
              style: Theme.of(context).textTheme.headlineMedium),
          PoText(
              text: widget.data!.poIdentification,
              data: widget.data,
              style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }

  Widget infoColumn(String title, Widget content, BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey)),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: content,
          )
        ]);
  }

  Widget percentageInfo(BuildContext context) {
    int percentage = widget.data?.totalItems != 0
        ? (widget.data!.receivedItems / widget.data!.totalItems * 100).toInt()
        : 0;
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$percentage%"),
          Text("${widget.data?.receivedItems}/${widget.data?.totalItems} Items",
              style: Theme.of(context).textTheme.labelSmall),
        ]);
  }


  Widget getASNInfo() {
    if (widget.data!.noCreatedAsnsExist()) {
      return const Text("No Advanced Shipping Notices Created");
    } else {
      return AsnStatusWidget(
        asns: widget.data!.asns,
      );
    }
  }
}