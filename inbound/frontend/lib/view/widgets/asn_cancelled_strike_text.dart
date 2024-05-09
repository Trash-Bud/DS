
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/entities/asn.dart';

import 'package:frontend/model/asn_status.dart';

class AsnText extends StatelessWidget{
  final String text;
  final Asn data;
  final TextStyle? style;
  const AsnText({super.key, required this.text, required this.data, required this.style});
  @override
  Widget build(BuildContext context) {
    return Text(text, style: data.status == ASNStatus.cancelled ? style?.copyWith(decoration: TextDecoration. lineThrough) : style);
  }
}

