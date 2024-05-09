import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/view/widgets/asn_list_navbar/asn_nav_bar.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'po_list_test.mocks.dart';

void main() {
  var asnApiMock = MockAsnRepository();
  var purchaseOrderApiMock = MockPurchaseOrderRepository();

  void mockGetASNs() {
    when(asnApiMock.getAsns()).thenAnswer((_) async => {});
  }

  Widget navBar = ASNNavBar(notifyParent: () {});

  group("Test ASN NavBar", () {
    testWidgets('NavBar Content Test', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      mockGetASNs();

      await tester.pumpWidget(
        ChangeNotifierProvider(
            create: (context) => AsnChangeNotifier(asnApiMock, purchaseOrderApiMock),
            builder: (context, _) => MaterialApp(
                  home: MediaQuery(
                    data: const MediaQueryData(size: Size(1200, 1200)),
                    child: Scaffold(
                      body: navBar,
                    ),
                  ),
                )),
      );

      await tester.pump(const Duration(seconds: 3));

      expect(find.text("Inbound ASNs"), findsOneWidget);
      expect(find.text("Search"), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      expect(find.text("ASN State"), findsOneWidget);
      expect(find.byKey(const Key("asnStateDropdown")), findsOneWidget);

      expect(find.byType(ElevatedButton), findsOneWidget);
      Text firstText = tester.firstWidget(find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.byType(Text),
      ));

      expect(firstText.data, "Create ASN");

      await tester.tap(find.text('Create ASN'));
      await tester.pumpAndSettle();


      expect(find.text("Upload a file to create a new ASN entry"), findsWidgets);
      expect(find.text("Download a Template .xlsx file to view an example of the format required."), findsWidgets);
      expect(find.text("Select file from device"), findsWidgets);
    });

    testWidgets('Small NavBar Content Test', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      mockGetASNs();

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => AsnChangeNotifier(asnApiMock, purchaseOrderApiMock),
          builder: (context, _) => MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(800, 800)),
              child: Scaffold(
                body: navBar,
              ),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 3));

      expect(find.text("ASNs"), findsOneWidget);
      expect(find.text("Search"), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      Icon buttonIcon = tester.firstWidget(find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.byType(Icon),
      ));

      expect(buttonIcon.icon, Icons.add);
    });

    testWidgets('NavBar Open Filter Dropdown', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      mockGetASNs();

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => AsnChangeNotifier(asnApiMock, purchaseOrderApiMock),
          builder: (context, _) => MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(1200, 1200)),
              child: Scaffold(
                body: navBar,
              ),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 3));

      expect(
          (tester.widget(find.byKey(const Key('asnStateDropdown')))
                  as DropdownButton)
              .value,
          equals(''));

      await tester.tap(find.text('ASN State'));
      await tester.pumpAndSettle();

      // There are 2 widgets of each: one in index stack of the dropdown and another in the menu
      expect(find.text("ASN State"), findsWidgets);
      expect(find.text("Pending"), findsWidgets);
      expect(find.text("Booked"), findsWidgets);
      expect(find.text("Received"), findsWidgets);
      expect(find.text("Cancelled"), findsWidgets);

      await tester.tap(find.text('Pending').last);
      await tester.pumpAndSettle();
      expect(
          (tester.widget(find.byKey(const Key('asnStateDropdown')))
                  as DropdownButton)
              .value,
          equals('Pending'));
    });
  });
}
