import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';

class PopUp extends StatelessWidget {
  final String title;
  final String content;
  final String positiveMessage;
  final String negativeMessage;
  final Function(BuildContext) onPressed;

  const PopUp(
      {super.key,
      required this.title,
      required this.content,
      required this.positiveMessage,
      required this.negativeMessage,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
        title: title,
        content: Text(
          content,
        ),
        actions: [
          GhostButton(
            width: 200,
            height: 37,
            onPressed: () {
              Navigator.pop(context);
            },
            title: negativeMessage,
          ),
          const SizedBox(
            width: 5,
          ),
          SecondaryButton(
            width: 200,
            height: 37,
            onPressed: () => onPressed(context),
            title: positiveMessage,
          ),
        ]);
  }
}
