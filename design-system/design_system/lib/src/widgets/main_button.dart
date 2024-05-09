import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Color color;
  final bool disabled;
  final void Function()? onPressed;
  final Widget? leading;
  final double width;
  final double? height;
  final EdgeInsetsGeometry padding;

  const MainButton({
    super.key,
    required this.title,
    required this.disabled,
    this.onPressed,
    this.leading,
    required this.padding , required this.color, this.width = 300, this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return color;
                } else if (states.contains(MaterialState.disabled)) {
                  return color.withOpacity(0.5);
                } else if (states.contains(MaterialState.hovered)) {
                  return color.withOpacity(0.7);
                }
                return color;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
        child: (leading != null) ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            leading!,
            Flexible( child:Text(title, style: bodyMediumStyle.copyWith(color: appVeryLightGreyColor))),
          ],
        ) : Text(title, style: bodyMediumStyle.copyWith(color: appVeryLightGreyColor))
      ),
    );
  }
}
