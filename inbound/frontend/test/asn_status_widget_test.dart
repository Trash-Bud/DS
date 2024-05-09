import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/view/widgets/asn_status_widget.dart';

Asn testAsnReceived = Asn(
    id: 32,
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
    id: 12,
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
    id: 43,
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
    id: 2313,
    shippingReference: "test asn 3",
    warehouse: "test warehouse 3",
    deliveryDate: DateTime.parse("2020-01-02"),
    carrier: "test carrier 3",
    cargoType: "Normal",
    shipperContact: "test contract 3",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-01"),
    status: ASNStatus.pending, address: '');

void main() {
  getChipColor(Color color) {
    return find.byWidgetPredicate(
          (widget) => widget is Chip && widget.backgroundColor == color,
      description: 'Chip widget with specific color and text',
    );
  }

  Widget createWidgetUnderTest(List<Asn> data) {
    return MaterialApp(home: Scaffold(body: AsnStatusWidget(asns: data)));
  }

  testWidgets("A chip for each ASN is created",
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest([testAsnReceived,testAsnReceived1,testAsnReceived2,testAsnReceived3]));
        expect(getChipColor(Colors.yellow),findsOneWidget);
        expect(find.text("(1) Pending"), findsOneWidget);
        expect(getChipColor(Colors.red),findsOneWidget);
        expect(find.text("(1) Cancelled"), findsOneWidget);
        expect(getChipColor(Colors.lightBlueAccent),findsOneWidget);
        expect(find.text("(1) Booked"), findsOneWidget);
        expect(getChipColor(Colors.green),findsOneWidget);
        expect(find.text("(1) Received"), findsOneWidget);
      });

  testWidgets("A chip for each ASN is created with ASNs with the same status",
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest([testAsnReceived,testAsnReceived,testAsnReceived2, testAsnReceived2,testAsnReceived3]));
        expect(getChipColor(Colors.yellow),findsOneWidget);
        expect(find.text("(1) Pending"), findsOneWidget);
        expect(getChipColor(Colors.lightBlueAccent),findsOneWidget);
        expect(find.text("(2) Booked"), findsOneWidget);
        expect(getChipColor(Colors.green),findsOneWidget);
        expect(find.text("(2) Received"), findsOneWidget);
      });
}
