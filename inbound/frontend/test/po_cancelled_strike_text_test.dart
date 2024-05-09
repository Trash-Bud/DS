import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'package:frontend/view/widgets/po_cancelled_strike_text.dart';

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
    id: 1,
    poIdentification: "AB001",
    name: "Test Purchase Order",
    supplier: "Test Supplier",
    receivedItems: 10,
    totalItems: 20,
    status: PoStatus.cancelled,
    asns: []);

void main() {
  textWithStrikeThrough() {
    return find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.style?.decoration == TextDecoration.lineThrough,
      description: '`Text` widget with strike through',
    );
  }

  Widget createWidgetUnderTest(PurchaseOrder data) {
    return MaterialApp(
        home: PoText(
            text: "Test", data: data, style: const TextStyle(fontSize: 8)));
  }

  testWidgets("Some text is strike through when a PO has been cancelled",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
    expect(textWithStrikeThrough(), findsNothing);

    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsnCancelled));
    expect(textWithStrikeThrough(), findsOneWidget);
  });
}
