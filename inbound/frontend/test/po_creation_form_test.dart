import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'package:frontend/view/widgets/create_overlay/create_po_form.dart';
import 'package:frontend/view/widgets/create_overlay/create_po_overlay.dart';
import 'package:mockito/mockito.dart';

import 'po_list_test.mocks.dart';



void main() {

  var purchaseOrderApiMock = MockPurchaseOrderRepository();
  List<PurchaseOrder> purchaseOrders = [
    PurchaseOrder(
        id: 8,
        poIdentification: "PO#2020-6136",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Store",
        receivedItems: 0,
        totalItems: 300,
        status: PoStatus.open,
        asns: []),
  ];

  void getPurchaseOrders(){
    when(purchaseOrderApiMock.getPurchaseOrders()).thenAnswer((_) async => {"totalResults":1,"purchaseOrders":purchaseOrders});
  }


  group("Test NavBar", ()  {
    const Widget overlay = CreatePoOverlay();
    //mock PurchaseOrder provider
    //mock User provider
    testWidgets('Test create PO form fill', (WidgetTester tester) async {
      getPurchaseOrders();
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: overlay,
        ),
      ));
      // test if the form is displayed
      expect(find.text("Create Purchase Order"), findsOneWidget);
      await tester.pumpAndSettle();
      // // place in text fields
      await tester.enterText(find.byKey(const Key("createPo-name")), "AW1819_Arzella_1");
      await tester.enterText(
          find.byKey(const Key("createPo-supplier")), "Arzelland Vintage Store");
      await tester.enterText(find.byKey(const Key("createPo-total-items")), "300");

      // verify that the text fields have the correct values
      expect(find.text("AW1819_Arzella_1"), findsOneWidget);
      expect(find.text("Arzelland Vintage Store"), findsOneWidget);
      expect(find.text("300"), findsOneWidget);
    });

    testWidgets("Test Discard", (WidgetTester tester) async {
      getPurchaseOrders();
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: overlay,
        ),
      ));
      // test if the form is displayed
      expect(find.text("Create Purchase Order"), findsOneWidget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key("createPo-name")), "AW1819_Arzella_1");
      await tester.enterText(
          find.byKey(const Key("createPo-supplier")), "Arzelland Vintage Store");
      await tester.enterText(find.byKey(const Key("createPo-total-items")), "300");

      // find Discard button
      expect(find.byKey(const Key("resetPoButton")), findsOneWidget);
      // tap the button
      await tester.tap(find.byKey(const Key("resetPoButton")));

      // verify that the text fields are empty
      expect(find.text("AW1819_Arzella_1"), findsNothing);
      expect(find.text("Arzelland Vintage Store"), findsNothing);
      expect(find.text("300"), findsNothing);
    });

    testWidgets("Test 0 as totalitems", (WidgetTester tester) async {
      getPurchaseOrders();
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: overlay,
        ),
      ));
      // test if the form is displayed
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key("createPo-name")), "AW1819_Arzella_1");
      await tester.enterText(
          find.byKey(const Key("createPo-supplier")), "Arzelland Vintage Store");
      await tester.enterText(find.byKey(const Key("createPo-total-items")), "0");

      PoFormState formState = tester.state(find.byType(PoForm));
      expect(formState.formKey.currentState!.validate(), false);
    });

    testWidgets("Test no name", (WidgetTester tester) async {
      getPurchaseOrders();
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: overlay,
        ),
      ));
      // test if the form is displayed
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key("createPo-name")), "");
      await tester.enterText(
          find.byKey(const Key("createPo-supplier")), "Arzelland Vintage Store");
      await tester.enterText(find.byKey(const Key("createPo-total-items")), "100");

      PoFormState formState = tester.state(find.byType(PoForm));
      expect(formState.formKey.currentState!.validate(), false);
    });


    testWidgets("Test no supplier", (WidgetTester tester) async {
      getPurchaseOrders();
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: overlay,
        ),
      ));
      // test if the form is displayed
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key("createPo-name")), "AW1819_Arzella_1");
      await tester.enterText(
          find.byKey(const Key("createPo-supplier")), "");
      await tester.enterText(find.byKey(const Key("createPo-total-items")), "100");

      PoFormState formState = tester.state(find.byType(PoForm));
      expect(formState.formKey.currentState!.validate(), false);
    });



    testWidgets("Test int form field", (WidgetTester tester) async {
      getPurchaseOrders();
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: overlay,
        ),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key("createPo-name")), "Arzelland Vintage Store");
      await tester.enterText(
          find.byKey(const Key("createPo-supplier")), "Arzelland Vintage Store");
      await tester.enterText(find.byKey(const Key("createPo-total-items")), "1fihwofhewo00");

      PoFormState formState = tester.state(find.byType(PoForm));
      expect(formState.formKey.currentState!.validate(), false);
    });


    testWidgets("Test max length field", (WidgetTester tester) async {
      getPurchaseOrders();
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: overlay,
        ),
      ));
      // test if the form is displayed
      await tester.pumpAndSettle();


      String str = "";
      for (int i = 0; i < 259; i++) {
        str += "a";
      }
      await tester.enterText(find.byKey(const Key("createPo-name")), str);
      await tester.enterText(
          find.byKey(const Key("createPo-supplier")), "Arzelland Vintage Store");
      await tester.enterText(find.byKey(const Key("createPo-total-items")), "100");

      PoFormState formState = tester.state(find.byType(PoForm));
      expect(formState.formKey.currentState!.validate(), false);
    });

  });
}