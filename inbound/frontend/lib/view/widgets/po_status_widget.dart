import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';

class PoStatusWidget extends StatelessWidget {
  final PurchaseOrder? po;

  const PoStatusWidget({super.key, required this.po});

  @override
  Widget build(BuildContext context) {
    return getTag();
  }

  Widget getTag() {
    return PoTag(text:(po?.status).toString(),status: po?.status);
  }

}

class PoTag extends StatelessWidget{
  final String text;
  final PoStatus? status;
  const PoTag({super.key, required this.text, required this.status});


  Widget smallTag() {
    return  Tag(text: text, textColor: appVeryLightGreyColor,
        backgroundColor:  PoStatus.poStatusColor[status]!
    );
  }
  @override
  Widget build(BuildContext context) {
    return smallTag();
  }

}