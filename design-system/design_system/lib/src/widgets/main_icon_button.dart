import 'package:design_system/src/colors.dart';
import 'package:flutter/material.dart';

class MainIconButton extends StatelessWidget {
  final bool disabled;
  final void Function()? onPressed;
  final IconData icon;
  final double width;
  final double height;
  final Color color;
  final EdgeInsetsGeometry padding;

  const MainIconButton({super.key,
    required this.disabled,
    this.onPressed,
    required this.icon,
    required this.width,
    required this.height,
    required this.padding, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ButtonStyle(
              padding:  MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return color;
                  } else if (states.contains(MaterialState.disabled)) {
                    return color.withOpacity(0.5);
                  }
                  else if (states.contains(MaterialState.hovered)){
                    return color.withOpacity(0.7);
                  }
                  return color;
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
              )
          ),
          child: Icon(icon, color: appVeryLightGreyColor)
      ),
    );
  }
}