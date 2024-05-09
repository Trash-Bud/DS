import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ColorCaption extends StatelessWidget {
  final Map<String, Color> statusColors;
  final Color defaultColor;

  const ColorCaption(this.statusColors,
      {this.defaultColor = appPrimaryColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      direction: Axis.horizontal,
      spacing: MediaQuery.of(context).size.height * 0.01,
      children: getColors(context),
    );
  }

  List<Widget> getColors(context) {
    return statusColors.entries
        .map((pair) => getColorInfo(pair.key, context))
        .toList();
  }

  Widget getColorInfo(String status, context) {
    return Column(children: [
      Icon(
        Icons.circle,
        color: statusColors[status] ?? defaultColor,
      ),
      Text(
        status.toString(),
        style: Theme.of(context).textTheme.labelSmall,
      ),
    ]);
  }
}
