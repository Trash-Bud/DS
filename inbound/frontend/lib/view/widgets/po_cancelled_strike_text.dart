
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/entities/purchase_order.dart';

import 'package:frontend/model/po_status.dart';

class PoText extends StatelessWidget{
  final String text;
  final PurchaseOrder? data;
  final TextStyle? style;
  const PoText({super.key, required this.text, required this.data, required this.style});
  @override
  Widget build(BuildContext context) {
    return Text(text, style: data?.status == PoStatus.cancelled ? style?.copyWith(decoration: TextDecoration. lineThrough) : style);
  }
}

