import 'package:flutter/material.dart';
import 'package:frontend/dashboard_item.dart';
import 'package:frontend/widgets/collapsible_text_button_icon.dart';

class DashboardItemButton extends StatelessWidget {
  final String _name;
  final IconData _icon;
  // ignore: unused_field
  final String _url;
  final bool open;
  final bool selected;
  final double minWidth;
  final Function() onPressed;

  DashboardItemButton(
      {super.key,
      required DashboardItem dashboardItem,
      required this.open,
      required this.minWidth,
      required this.onPressed,
      this.selected = false})
      : _name = dashboardItem.name,
        _icon = dashboardItem.icon,
        _url = dashboardItem.url;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 20;
    final double horizontalPadding = (minWidth - iconSize) / 2;
    const double verticalPadding = 22;

    return CollapsibleTextButtonIcon(
      open: open,
      color: selected ? Theme.of(context).highlightColor : null,
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      iconSize: iconSize,
      icon: Icon(_icon),
      label: Text(
        _name,
        style: const TextStyle(
          fontSize: iconSize - 2,
          height: 1.1,
        ),
      ),
    );
  }
}
