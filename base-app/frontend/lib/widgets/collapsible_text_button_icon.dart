import 'package:flutter/material.dart';

import 'text_button_icon.dart';

class CollapsibleTextButtonIcon extends StatelessWidget {
  final bool _open;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final Color overlayColor;
  final Color? color;
  final Widget icon;
  final Widget label;
  final Function() onPressed;

  const CollapsibleTextButtonIcon({
    super.key,
    open = false,
    required this.padding,
    required this.iconSize,
    this.overlayColor = const Color.fromARGB(7, 20, 21, 22),
    this.color,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : _open = open;

  @override
  Widget build(BuildContext context) {
    return _open
        ? TextButtonIcon(
            padding: padding,
            iconSize: iconSize,
            overlayColor: overlayColor,
            color: color,
            icon: icon,
            label: label,
            onPressed: onPressed,
          )
        : Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              overlayColor: MaterialStatePropertyAll(overlayColor),
              child: Padding(
                padding: padding,
                child: SizedBox(
                  height: iconSize,
                  child: Row(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: IconTheme.merge(
                          data: IconThemeData(size: iconSize, color: color),
                          child: icon,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
