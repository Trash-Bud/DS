import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class TertiaryIconButton extends StatelessWidget {
  final bool disabled;
  final void Function()? onPressed;
  final IconData icon;
  final double? width;
  final double height;
  final Color color;
  final EdgeInsetsGeometry padding;

  const TertiaryIconButton({
    super.key,
    this.disabled = false,
    this.onPressed,
    required this.icon,
    this.width = 50,
    this.height = 50,
    this.color = appPrimaryColor,
    this.padding = const EdgeInsets.all(10),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
          onPressed: disabled ? null : onPressed,
          style: TextButton.styleFrom(
            padding: padding,
            backgroundColor: Colors.transparent,
            textStyle: bodyMediumStyle,
          ),
          child: Icon(icon, color: disabled ? appDisableGrey: color)),
    );
  }
}
