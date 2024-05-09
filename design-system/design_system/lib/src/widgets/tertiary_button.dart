import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final void Function()? onPressed;
  final Widget? leading;
  final double width;
  final double? height;
  final Color? color;
  final EdgeInsets? padding;

  const TertiaryButton({
    super.key,
    required this.title,
    this.disabled = false,
    this.onPressed,
    this.leading,
    this.color = appPrimaryColor,
    this.padding, this.width = 300, this.height = 50,
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
          disabledForegroundColor: appDisableGrey,
          foregroundColor: color,
          backgroundColor: Colors.transparent,
          textStyle: bodyMediumStyle,
        ),
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
