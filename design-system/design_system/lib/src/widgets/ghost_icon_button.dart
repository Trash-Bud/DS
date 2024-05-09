import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class GhostIconButton extends StatelessWidget {
  final bool disabled;
  final void Function()? onPressed;
  final IconData icon;
  final double? width;
  final double height;
  final EdgeInsetsGeometry padding;

  const GhostIconButton({super.key,
    this.disabled = false,
    this.onPressed,
    required this.icon,
    this.width = 50,
    this.height = 50,
    this.padding = const EdgeInsets.all(10),
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: disabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          foregroundColor: appDarkColor, backgroundColor: Colors.transparent,
          disabledForegroundColor: appDisableGrey,
          textStyle: bodyMediumStyle,
          side:  BorderSide(
            color: (disabled || onPressed == null) ? appDisableGrey : appMediumGreyColor
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )
        ),
        child: Icon(icon, color: disabled ? appDisableGrey: appDarkColor)
      ),
    );
  }
}
