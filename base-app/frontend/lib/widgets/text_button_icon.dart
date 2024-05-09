import 'package:flutter/material.dart';

class TextButtonIcon extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final Color overlayColor;
  final Color? color;
  final Widget icon;
  final Widget label;
  final Function() onPressed;

  const TextButtonIcon({
    super.key,
    required this.padding,
    required this.iconSize,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.overlayColor = const Color.fromARGB(5, 20, 21, 22),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
        alignment: AlignmentDirectional.centerStart,
        overlayColor: MaterialStatePropertyAll(overlayColor),
        foregroundColor: const MaterialStatePropertyAll(
          Color.fromARGB(255, 20, 21, 22),
        ),
      ),
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: iconSize,
          child: ClipRect(
            child: Row(
              children: [
                IconTheme.merge(
                    data: IconThemeData(size: iconSize, color: color),
                    child: icon),
                Flexible(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.antiAlias,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(
                        width: 18,
                      ),
                      label,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
