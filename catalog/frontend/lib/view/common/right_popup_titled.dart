import 'package:flutter/material.dart';

class RightPopupTitled extends StatelessWidget {
  const RightPopupTitled({super.key, required this.title, required this.child});

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
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            style: const TextStyle(fontSize: 28),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black),
                ],
              ),
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
}
