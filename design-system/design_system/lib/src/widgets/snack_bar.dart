import 'package:flutter/material.dart';

import '../../design_system.dart';

class _CustomSnackBar extends SnackBar {
  final Widget newContent;
  final Color color;
  final BuildContext context;


  _CustomSnackBar(this.newContent, this.color, this.context, {super.key,  int duration = 2500, double? width})
      : super(
    content: newContent,
    duration: Duration(milliseconds: duration),
    backgroundColor: color,
    padding: const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0, // Inner padding for SnackBar content.
    ),
    width: width ?? 500,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

class CustomSnackBarError extends _CustomSnackBar {
  final BuildContext newContext;
  final String warningMessage;

  CustomSnackBarError(this.newContext, this.warningMessage,  {super.key, int duration = 2500, double? width})
      : super(Text(warningMessage, style: const TextStyle(color: appVeryLightGreyColor)), appWarning, newContext, duration: duration, width:width);
}

class CustomSnackBarInformation extends _CustomSnackBar {
  final BuildContext newContext;
  final String message;

  CustomSnackBarInformation(this.newContext, this.message,  {super.key, int duration = 2500, double? width})
      : super(Text(message, style: const TextStyle(color: appVeryLightGreyColor)), appPrimaryColor, newContext, duration: duration, width:width);
}

class CustomSnackBarLoaded extends _CustomSnackBar {
  final BuildContext newContext;
  final String message;

  CustomSnackBarLoaded(this.newContext, this.message,  {super.key, int duration = 2500, double? width})
      : super(Text(message, style: const TextStyle(color: appVeryLightGreyColor)), appLoaded, newContext, duration: duration, width:width);
}

class CustomSnackBarLoading extends _CustomSnackBar {
  final BuildContext newContext;

  static Widget loading(){
    return SizedBox(
      height: 10,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator())
          ]),
    );
  }

  CustomSnackBarLoading(this.newContext, {super.key, int duration = 2500, double? width})
      : super(loading(), appLoading, newContext, duration: duration, width:width);

}

