import 'package:design_system/src/colors.dart';
import 'package:design_system/src/styles/styles.dart';
import 'package:flutter/material.dart';

class GenericDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final List<Widget> actions;

  const GenericDialog(
      {super.key, required this.title, this.actions = const [], this.content});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: appDarkColor,
            ),
      ),
      child: AlertDialog(
        titlePadding:
            const EdgeInsets.only(left: 22, right: 22, top: 23, bottom: 12),
        title: Text(
          title,
          style: headlineSmallStyle.apply(color: appDarkColor, fontWeightDelta: 4),
        ),
        contentPadding: const EdgeInsets.all(0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (content != null)
              Padding(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 0, bottom: 12),
                child: content!,
              ),
            if (actions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.5),
                child: Container(
                  decoration: const BoxDecoration(
                    color: appDisableGrey,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
