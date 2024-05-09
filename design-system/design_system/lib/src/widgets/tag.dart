import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const Tag(
      {super.key,
      required this.text,
      this.backgroundColor = tagBackgroundColor,
      this.textColor = tagLabelTextColor});

  @override
  Widget build(BuildContext context) {
    return _smallTag();
  }

  Widget _smallTag() {
    return Chip(
      elevation: 2,
      autofocus: true,
      shadowColor: appLightGreyColor,
      backgroundColor: backgroundColor,
      label: Text(text),
      labelStyle: TextStyle(fontSize: 11, color: textColor),
    );
  }
}
