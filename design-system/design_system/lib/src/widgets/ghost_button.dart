import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class GhostButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final void Function()? onPressed;
  final Widget? leading;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const GhostButton({
    super.key,
    required this.title,
    this.disabled = false,
    this.onPressed,
    this.leading,
    this.padding,
    this.width = 300,
    this.height = 50,
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
            foregroundColor: appDarkColor,
            backgroundColor: Colors.transparent,
            disabledForegroundColor: appDisableGrey,
            textStyle: bodyMediumStyle,
            side: BorderSide(
                color: (disabled || onPressed == null)
                    ? appDisableGrey
                    : appMediumGreyColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
        child: (leading != null) ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            leading!,
            Flexible( child:Text(title)),
          ],
        ) : Text(title),
      ),
    );
  }
}
