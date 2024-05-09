import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'package:frontend/view/widgets/po_status_widget.dart';

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
PurchaseOrder purchaseOrderNoAsnOpen = PurchaseOrder(
    id: 1,
    poIdentification: "AB001",
    name: "Test Purchase Order",
    supplier: "Test Supplier",
    receivedItems: 10,
    totalItems: 20,
    status: PoStatus.open,
    asns: []);
PurchaseOrder purchaseOrderNoAsnArchived = PurchaseOrder(
    id: 1,
    poIdentification: "AB001",
    name: "Test Purchase Order",
    supplier: "Test Supplier",
    receivedItems: 10,
    totalItems: 20,
    status: PoStatus.archived,
    asns: []);

void main() {
  getColor(Color color) {
    return find.byWidgetPredicate(
      (widget) => widget is Chip && widget.backgroundColor == color,
      description: 'Chip widget with specific color',
    );
  }

  Widget createWidgetUnderTest(PurchaseOrder data) {
    return MaterialApp(home: Scaffold(body: PoStatusWidget(po: data)));
  }

  testWidgets("Widgets are red and say cancelled if the PO is cancelled",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsnCancelled));
    expect(find.text("Cancelled"), findsOneWidget);
    expect(getColor( cancelledPo), findsOneWidget);
  });

  testWidgets("Widgets are yellow and say cancelled if the PO is in progress",
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsn));
        expect(find.text("In Progress"), findsOneWidget);
        expect(getColor(inProgressPo), findsOneWidget);
      });

  testWidgets("Widgets are green and say cancelled if the PO is open",
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsnOpen));
        expect(find.text("Open"), findsOneWidget);
        expect(getColor(openPo), findsOneWidget);
      });

  testWidgets("Widgets are blue and say cancelled if the PO is archived",
          (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(purchaseOrderNoAsnArchived));
        expect(find.text("Archived"), findsOneWidget);
        expect(getColor(archivedPo), findsOneWidget);
      });
}
