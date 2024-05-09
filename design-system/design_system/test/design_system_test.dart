import 'package:design_system/src/widgets/radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("radio value", (tester) async {
    int changed = 0;
    int curValue = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Row(
                children: [
                  RadioButton(
                    key: const Key("radio"),
                    onChanged: (p0) {
                      setState(() {
                        changed++;
                        curValue = p0;
                      });
                    },
                    value: 0,
                    groupValue: curValue,
                  ),
                  RadioButton(
                    key: const Key("radio2"),
                    onChanged: (p0) {
                      setState(() {
                        changed++;
                        curValue = p0;
                      });
                    },
                    value: 1,
                    groupValue: curValue,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    Finder radioFinder = find.byKey(const Key("radio"));
    Finder radioFinder2 = find.byKey(const Key("radio2"));

    await tester.tap(radioFinder);
    await tester.pump();

    expect(curValue, 0);
    expect(changed, 0);

    await tester.tap(radioFinder2);
    await tester.pump();

    expect(curValue, 1);
    expect(changed, 1);

    await tester.tap(radioFinder);
    await tester.pump();

    expect(curValue, 0);
    expect(changed, 2);
  });
}
