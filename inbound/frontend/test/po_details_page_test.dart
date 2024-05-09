import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'package:frontend/view/pages/po_details.dart';
import 'package:frontend/view/widgets/asn_status_widget.dart';
import 'package:frontend/view/widgets/po_status_widget.dart';
import 'package:provider/provider.dart';

import 'po_list_test.mocks.dart';

PurchaseOrder purchaseOrderNoAsn = PurchaseOrder(
    id: 1,
    poIdentification: "AB001",
    name: "Test Purchase Order",
    supplier: "Test Supplier",
    receivedItems: 10,
    totalItems: 20,
    status: PoStatus.inProgress,
    asns: []);
PurchaseOrder purchaseOrderNoAsnCancelled = PurchaseOrder(
    id: 2,
    poIdentification: "AB001",
    name: "Test Purchase Order",
    supplier: "Test Supplier",
    receivedItems: 10,
    totalItems: 20,
    status: PoStatus.cancelled,
    asns: []);

Asn testAsnReceived = Asn(
    id: 1,
    shippingReference: "test asn",
    warehouse: "test warehouse",
    deliveryDate: DateTime.parse("2020-01-02"),
    carrier: "test carrier",
    cargoType: "Normal",
    shipperContact: "test contract",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-01"),
    status: ASNStatus.received, address: '');
Asn testAsnReceived1 = Asn(
    id: 2,
    shippingReference: "test asn 1",
    warehouse: "test warehouse 1",
    deliveryDate: DateTime.parse("2020-01-06"),
    carrier: "test carrier 1",
    cargoType: "Normal",
    shipperContact: "test contract 1",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-05"),
    status: ASNStatus.cancelled, address: '');
Asn testAsnReceived2 = Asn(
    id: 3,
    shippingReference: "test asn 2",
    warehouse: "test warehouse 2",
    deliveryDate: DateTime.parse("2020-01-02"),
    carrier: "test carrier 2",
    cargoType: "Normal",
    shipperContact: "test contract 2",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-01"),
    status: ASNStatus.booked, address: '');
Asn testAsnReceived3 = Asn(
    id: 4,
    shippingReference: "test asn 3",
    warehouse: "test warehouse 3",
    deliveryDate: DateTime.parse("2020-01-02"),
    carrier: "test carrier 3",
    cargoType: "Normal",
    shipperContact: "test contract 3",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-01"),
    status: ASNStatus.pending, address: '');
Asn testAsnReceived4 = Asn(
    id: 5,
    shippingReference: "test asn 4",
    warehouse: "test warehouse 4",
    deliveryDate: DateTime.parse("2020-01-02"),
    carrier: "test carrier 4",
    cargoType: "Normal",
    shipperContact: "test contract 4",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-01"),
    status: ASNStatus.received, address: '');
Asn testAsnReceived5 = Asn(
    id: 6,
    shippingReference: "test asn 5",
    warehouse: "test warehouse 5",
    deliveryDate: DateTime.parse("2020-01-06"),
    carrier: "test carrier 5",
    cargoType: "Normal",
    shipperContact: "test contract 5",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-05"),
    status: ASNStatus.booked, address: '');

PurchaseOrder purchaseOrderWithAsn = PurchaseOrder(
    id: 2,
    poIdentification: "AB002",
    name: "Test Purchase Order 2",
    supplier: "Test Supplier 2",
    receivedItems: 10,
    totalItems: 20,
    status: PoStatus.inProgress,
    asns: [testAsnReceived]);
PurchaseOrder purchaseOrderWithMultipleAsn = PurchaseOrder(
    id: 3,
    poIdentification: "AB002",
    name: "Test Purchase Order 2",
    supplier: "Test Supplier 2",
    receivedItems: 10,
    totalItems: 20,
    status: PoStatus.inProgress,
    asns: [
      testAsnReceived,
      testAsnReceived4,
      testAsnReceived1,
      testAsnReceived5,
      testAsnReceived2,
      testAsnReceived3
    ]);

void main() {
  textWithStrikeThrough() {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.style?.decoration == TextDecoration.lineThrough,
      description: '`Text` widget with strike through',
    );
  }

  var purchaseOrderApiMock = MockPurchaseOrderRepository();
  var asnApiMock = MockAsnRepository();

  Widget createWidgetUnderTest(PurchaseOrder data) {
    return MaterialApp(
        home: MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => PurchaseOrderChangeNotifier(purchaseOrderApiMock)),
      ChangeNotifierProvider(create: (_) => AsnChangeNotifier(asnApiMock, purchaseOrderApiMock))
    ], child: MediaQuery(data: const MediaQueryData(size: Size(700, 700)),
    child: PoDetails(data: data))));
  }

  testWidgets("BackPage Button is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('Back'), findsOneWidget);
  });

  testWidgets("PO name is displayed once", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('Test Purchase Order'), findsOneWidget);
  });

  testWidgets("PO identification is displayed once",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('AB001'), findsOneWidget);
  });

  testWidgets("PO supplier is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('Test Supplier'), findsOneWidget);
  });

  testWidgets("Colum titles are displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('Purchase Order Status'), findsOneWidget);
    expect(find.text('Received'), findsOneWidget);
  });

  testWidgets("Status is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.byType(PoStatusWidget), findsOneWidget);
    expect(find.text("In Progress"), findsOneWidget);
  });

  testWidgets("Amount of items received by total amount of items is displayed",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('10/20 Items'), findsOneWidget);
  });

  testWidgets("Item percentage is displayed", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('50%'), findsOneWidget);
  });

  testWidgets("Create ASN button is shown", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets("Shipping notice number is displayed",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('Advanced Shipping Notices (0)'), findsOneWidget);
    expect(find.text('No Advanced Shipping Notices Created'), findsOneWidget);
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderWithAsn));
    expect(find.text('Advanced Shipping Notices (1)'), findsOneWidget);
    await tester
        .pumpWidget(createWidgetUnderTest(purchaseOrderWithMultipleAsn));
    expect(find.text('Advanced Shipping Notices (6)'), findsOneWidget);
  });

  testWidgets("Show Asn Status", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.byType(AsnStatusWidget), findsNothing);
    expect(find.byType(AsnTag), findsNothing);
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderWithAsn));
    expect(find.byType(AsnStatusWidget), findsOneWidget);
    expect(find.byType(AsnTag),
        findsNWidgets(2)); //1 in the PO description and another in the ASN card
    expect(find.text("(1) Received"), findsOneWidget);
    await tester
        .pumpWidget(createWidgetUnderTest(purchaseOrderWithMultipleAsn));
    expect(find.byType(AsnStatusWidget), findsOneWidget);
    expect(find.byType(AsnTag),
        findsNWidgets(10)); //4 in the PO description and 6 in the ASN cards
    expect(find.text("(2) Received"), findsOneWidget);
    expect(find.text("(1) Cancelled"), findsOneWidget);
    expect(find.text("(2) Booked"), findsOneWidget);
    expect(find.text("(1) Pending"), findsOneWidget);
  });

  testWidgets("Title for advanced shipping notices section is shown",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text('Advanced Shipping Notices'), findsOneWidget);
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderWithAsn));
    expect(find.text('Advanced Shipping Notices'), findsOneWidget);
  });

  testWidgets("ASN titles are shown", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderWithAsn));
    expect(find.text('test asn'), findsOneWidget);
    await tester
        .pumpWidget(createWidgetUnderTest(purchaseOrderWithMultipleAsn));
    expect(find.text('test asn'), findsOneWidget);
    expect(find.text('test asn 1'), findsOneWidget);
    expect(find.text('test asn 2'), findsOneWidget);
    expect(find.text('test asn 3'), findsOneWidget);
    expect(find.text('test asn 4'), findsOneWidget);
    expect(find.text('test asn 5'), findsOneWidget);
  });

  testWidgets("ASN Details are shown", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderWithAsn));
    expect(find.text('test asn'), findsOneWidget);
    expect(find.text('ASN test asn Information\n'), findsOneWidget);
    expect(find.text('Warehouse: test warehouse'), findsOneWidget);
    expect(find.text('Delivery Date: 2020-01-02 00:00:00.000'), findsOneWidget);
    expect(find.text('Carrier: test carrier'), findsOneWidget);
    expect(find.text('Shipper Contract: test contract'), findsOneWidget);
    expect(find.text('Purchase Order Date: 2020-01-01 00:00:00.000'),
        findsOneWidget);
    expect(find.text('Status: Received'), findsOneWidget);
  });

  testWidgets(
      "When clicked that asn details start being shown and the other one's disappear",
      (WidgetTester tester) async {
    await tester
        .pumpWidget(createWidgetUnderTest(purchaseOrderWithMultipleAsn));
    expect(find.text('test asn'), findsOneWidget);
    expect(find.text('ASN test asn Information\n'), findsOneWidget);
    expect(find.text('Warehouse: test warehouse'), findsOneWidget);
    expect(find.text('Delivery Date: 2020-01-02 00:00:00.000'), findsOneWidget);
    expect(find.text('Carrier: test carrier'), findsOneWidget);
    expect(find.text('Shipper Contract: test contract'), findsOneWidget);
    expect(find.text('Purchase Order Date: 2020-01-01 00:00:00.000'),
        findsOneWidget);
    expect(find.text('Status: Received'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key("ASN_Card_2")));
    printOnFailure(find.byKey(const Key("ASN_Card_2")).toString());
    await tester.tap(find.byKey(const Key("ASN_Card_2")));
    await tester.pumpAndSettle();
    expect(find.text('ASN test asn Information\n'), findsNothing);
    expect(find.text('ASN test asn 1 Information\n'), findsOneWidget);
    expect(find.text('Warehouse: test warehouse 1'), findsOneWidget);
    expect(find.text('Delivery Date: 2020-01-06 00:00:00.000'), findsOneWidget);
    expect(find.text('Carrier: test carrier 1'), findsOneWidget);
    expect(find.text('Shipper Contract: test contract 1'), findsOneWidget);
    expect(find.text('Purchase Order Date: 2020-01-05 00:00:00.000'),
        findsOneWidget);
    expect(find.text('Status: Cancelled'), findsOneWidget);
  });

  testWidgets("Some text is strike through when a PO has been cancelled",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(find.text("In Progress"), findsOneWidget);
    expect(textWithStrikeThrough(), findsNothing);

    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsnCancelled));
    expect(find.text("Cancelled"), findsOneWidget);
    expect(textWithStrikeThrough(), findsNWidgets(3));
  });
}
