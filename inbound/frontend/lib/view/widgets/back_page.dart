
import 'package:flutter/material.dart';

class BackPage extends StatelessWidget{
  const BackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
      child: InkWell(
        child: Row(
          children: [
            const Icon(Icons.arrow_back,color: Colors.grey),
            Text(
            "Back",
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.w100, color: Colors.grey),
          ),]
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

}