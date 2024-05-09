import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TitledOverlay extends StatelessWidget {
  const TitledOverlay({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Column(children: [
              _buildHeader(title),
              const SizedBox(height: 10),
              Expanded(
                child: child,
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(title) => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: BoxText.headlineLarge(title)
          ),
          const Divider(color: appDarkColor),
        ],
      );

  static void showTitledOverlay(BuildContext context, String title, Widget child) {
    showDialog(
        context: context,
        builder: (context) => TitledOverlay(title: title, child: child));
  }
}
