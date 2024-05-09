import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class MenuTab extends StatefulWidget {
  final Color overlayColor;
  final BorderRadius borderRadius;
  final bool selected;
  final Function()? onPressed;
  final String text;
  final double height;
  final double fontSizeDelta;
  final TextStyle fontStyle;
  final Widget right;

  const MenuTab(
      {super.key,
      this.overlayColor = const Color.fromARGB(15, 20, 21, 22),
      this.borderRadius = const BorderRadius.all(Radius.circular(4)),
      this.selected = false,
      this.onPressed,
      this.height = 80,
      this.fontSizeDelta = 0,
      this.fontStyle = headlineSmallStyle,
      this.right = const SizedBox(),
      required this.text});

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 6,
      ),
      child: SizedBox(
        height: widget.height,
        child: Container(
          key: const Key("item-container"),
          decoration: BoxDecoration(
            color: widget.selected ? appFocusColor : appDialogBackgroundColor,
            borderRadius: widget.borderRadius,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: widget.borderRadius,
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              onTap: widget.onPressed,
              onHover: (value) {
                setState(() {
                  _hover = value;
                });
              },
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  if (widget.selected || _hover)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 2),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 3),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: appPrimaryColor,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        Text(
                          widget.text,
                          style: widget.fontStyle.apply(
                            fontWeightDelta: widget.selected ? 2 : 1,
                            fontSizeDelta: widget.fontSizeDelta,
                          ),
                        ),
                        Expanded(
                          child: widget.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
