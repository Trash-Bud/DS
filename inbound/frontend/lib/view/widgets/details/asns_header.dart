import 'package:flutter/material.dart';

class AsnsHeader extends StatelessWidget {
  const AsnsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
      child: Text("Advanced Shipping Notices",
          style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
