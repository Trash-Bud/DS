import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'main_icon_button.dart';

class PrimaryIconButton extends MainIconButton {
  const PrimaryIconButton({
    super.key,
    bool disabled = false,
    Function()? onPressed,
    required IconData icon,
    double width = 50.0,
    double height = 50.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10.0),
  }) : super(
      color: appPrimaryColor,
      onPressed: onPressed,
      disabled: disabled,
      icon: icon,
      width: width,
      height: height,
      padding: padding);
}