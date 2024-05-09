import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'main_button.dart';

class SecondaryButton extends MainButton {
  const SecondaryButton({
    super.key,
    required String title,
    bool disabled = false,
    Function()? onPressed,
    Widget? leading,
    double? height = 50,
    required double width,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10),
  }) : super(
      color: appSecondaryColor,
      title: title,
      disabled: disabled,
      onPressed: onPressed,
      leading: leading,
      height: height,
      width: width,
      padding: padding);

  const SecondaryButton.defaultSize({
    super.key,
    required String title,
    bool disabled = false,
    Function()? onPressed,
    double? height = 50,
    Widget? leading,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10),
  }) : super(
      color: appSecondaryColor,
      title: title,
      disabled: disabled,
      onPressed: onPressed,
      height: height,
      leading: leading,
      padding: padding);
}