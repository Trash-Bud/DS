import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/view/widgets/create_overlay/create_po_form.dart';
import 'package:frontend/view/widgets/po_list_navbar/po_nav_bar.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'po_list_test.mocks.dart';

void main() {
  var purchaseOrderApiMock = MockPurchaseOrderRepository();

  void mockGetPurchaseOrders(){
    when(purchaseOrderApiMock.getPurchaseOrders()).thenAnswer((_) async => {"totalResults":0,"purchaseOrders":[]});
  }

  Widget navBar = const PoNavBar();

  group("Test NavBar", () {
    testWidgets('NavBar Content Test', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      mockGetPurchaseOrders();

      await tester.pumpWidget(ChangeNotifierProvider(
          create: (context) => PurchaseOrderChangeNotifier(purchaseOrderApiMock),
          builder: (context, _) => MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(1200, 1200)),
              child: Scaffold(
                body: navBar,
              ),
            ),
          )
        ),
      );

      await tester.pump(const Duration(seconds: 3));

      expect(find.text("Inbound Purchase Orders"), findsOneWidget);
      expect(find.text("Search"), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      expect(find.text("PO State"), findsOneWidget);
      expect(find.byKey(const Key("poStateDropdown")), findsOneWidget);

      expect(find.byType(ElevatedButton), findsOneWidget);
      Text firstText = tester.firstWidget(find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.byType(Text),
      ));

      expect(firstText.data, "Create PO");
    });

    testWidgets('Small NavBar Content Test', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      mockGetPurchaseOrders();

      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => PurchaseOrderChangeNotifier(purchaseOrderApiMock),
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

      expect(find.text("POs"), findsOneWidget);
      expect(find.text("Search"), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      Icon buttonIcon = tester.firstWidget(find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.byType(Icon),
      ));

      expect(buttonIcon.icon, Icons.add);
    });

    testWidgets('NavBar Show Create Overlay', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      mockGetPurchaseOrders();

      await tester.pumpWidget(ChangeNotifierProvider(
          create: (context) => PurchaseOrderChangeNotifier(purchaseOrderApiMock),
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

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(PoForm), findsOneWidget);
      expect(find.byType(FormBuilder), findsOneWidget);
    });

    testWidgets('NavBar Open Filter Dropdown', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(3840, 2160);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      mockGetPurchaseOrders();

      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => PurchaseOrderChangeNotifier(purchaseOrderApiMock),
        builder: (context, _) =>  MaterialApp(
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

      expect((tester.widget(find.byKey(const Key('poStateDropdown'))) as DropdownButton).value,
          equals(''));

      await tester.tap(find.text('PO State'));
      await tester.pumpAndSettle();

      // There are 2 widgets of each: one in index stack of the dropdown and another in the menu
      expect(find.text("PO State"), findsWidgets);
      expect(find.text("Open"), findsWidgets);
      expect(find.text("In Progress"), findsWidgets);
      expect(find.text("Archived"), findsWidgets);
      expect(find.text("Cancelled"), findsWidgets);

      await tester.tap(find.text('Open').last);
      await tester.pumpAndSettle();
      expect((tester.widget(find.byKey(const Key('poStateDropdown'))) as DropdownButton).value,
          equals('Open'));
    });
  });
}
