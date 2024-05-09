import 'package:design_system/src/colors.dart';
import 'package:design_system/src/widgets/main_button.dart';
import 'package:flutter/cupertino.dart';

class PrimaryButton extends MainButton {
  const PrimaryButton({
    super.key,
    required String title,
    bool disabled = false,
    Function()? onPressed,
    Widget? leading,
    double? height,
    required double width,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10),
  }) : super(
            color: appPrimaryColor,
            title: title,
            disabled: disabled,
            onPressed: onPressed,
            leading: leading,
            height: height,
            width: width,
            padding: padding);

  const PrimaryButton.defaultSize({
    super.key,
    required String title,
    bool disabled = false,
    Function()? onPressed,
    Widget? leading,
    double? height = 50,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10),
  }) : super(
      color: appPrimaryColor,
      title: title,
      disabled: disabled,
      onPressed: onPressed,
      height:height,
      leading: leading,
      padding: padding);

}
