import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/view/widgets/asn_cancelled_strike_text.dart';

Asn testAsnReceived = Asn(
    id: 0,
    shippingReference: "test asn",
    warehouse: "test warehouse",
    deliveryDate: DateTime.parse("2020-01-02"),
    carrier: "test carrier",
    cargoType: "Normal",
    shipperContact: "test contract",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-01"),
    status: ASNStatus.received, address: '');
Asn testAsnCancelled = Asn(
    id: 1,
    shippingReference: "test asn 1",
    warehouse: "test warehouse 1",
    deliveryDate: DateTime.parse("2020-01-06"),
    carrier: "test carrier 1",
    cargoType: "Normal",
    shipperContact: "test contract 1",
    poIdentification: 1,
    purchaseOrderDate: DateTime.parse("2020-01-05"),
    status: ASNStatus.cancelled, address: '');

void main() {
  textWithStrikeThrough() {
    return find.byWidgetPredicate(
          (widget) =>
      widget is Text &&
          widget.style?.decoration == TextDecoration.lineThrough,
      description: '`Text` widget with strike through',
    );
  }

  Widget createWidgetUnderTest(Asn data) {
    return MaterialApp(
        home: AsnText(
            text: "Test", data: data, style: const TextStyle(fontSize: 8)));
  }

  testWidgets("Some text is strike through when an ASN has been cancelled",
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(testAsnReceived));
        expect(textWithStrikeThrough(), findsNothing);

        await tester.pumpWidget(createWidgetUnderTest(testAsnCancelled));
        expect(textWithStrikeThrough(), findsOneWidget);
      });
}
