import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'package:frontend/view/widgets/po_card/next_reception_status_section.dart';
import 'package:frontend/view/widgets/po_card/po_card.dart';
import 'package:frontend/view/widgets/po_card/po_info_section.dart';

PurchaseOrder mockPO() {
  return PurchaseOrder(
      poIdentification: "PO#2020-6136",
      name: "AW1819_Arzella_1",
      supplier: "Arzelland Vintage Store",
      receivedItems: 0,
      totalItems: 0,
      status: PoStatus.cancelled,
      asns: [],
      id: 8);
}

void main() {
  PurchaseOrderCard poCard = PurchaseOrderCard(mockPO());

  // TODO: verify if object key is best, although it is not a good distinction
  var poInfoSectionKey = Key("poInfoSection${mockPO().id}");
  var poNameTextKey = Key("poNameText${mockPO().id}");
  const poName = "AW1819_Arzella_1";
  var poIdTextKey = Key("poIdText${mockPO().id}");
  var poIdText = "PO#2020-6136";
  var supplierNameKey = Key("supplierName${mockPO().id}");
  var supplierText = "Arzelland Vintage Store";
  var receivedItemsKey = Key("receivedItemsSection${mockPO().id}");
  var poStatusString = "Cancelled";
  var closeAsnsKey = Key("closedAsns${mockPO().id}");
  var noOfClosedAsnsText = "0/0";
  var nextAsnStatusKey = Key("nextAsnsStatusSection${mockPO().id}");
  var moreOptionsButtonKey = Key("moreOptionsButton${mockPO().id}");
  var nextASNText = "All advance shipping notices cancelled";

  testWidgets('Test PO card', (WidgetTester tester) async {
    await tester.pumpWidget(Builder(builder: (context) {
      return MaterialApp(
        home: Scaffold(
          body: MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(2000, 2000)),
              child: Scaffold(
                body: SizedBox(
                  width: 1000,
                  height: 1000,
                  child: AppDataTable(
                      columnNames: const [
                        "PO Number",
                        "Supplier",
                        "Received",
                        "Closed",
                        "Next Reception Status",
                        "",
                      ],
                      rows: [
                        poCard.build(context)
                      ]),
                ),
              ),
            ),
          ),
        ),
      );
    }));

    await tester.pumpAndSettle();

    expect(find.byKey(poInfoSectionKey), findsOneWidget);

    Text name = tester.firstWidget(find.descendant(
      of: find.byType(PoInfoSection),
      matching: find.byKey(poNameTextKey),
    ));

    expect(name.data, poName);

    Text id = tester.firstWidget(find.descendant(
      of: find.byType(PoInfoSection),
      matching: find.byKey(poIdTextKey),
    ));

    expect(id.data, poIdText);

    Text chipText = tester.firstWidget(find.descendant(
      of: find.byType(Chip),
      matching: find.byType(Text),
    ));
    expect(chipText.data, poStatusString);


    expect(find.byKey(supplierNameKey), findsOneWidget);
    Text supplier = tester.firstWidget(find.byKey(supplierNameKey));
    expect(supplier.data, supplierText);

    expect(find.byKey(receivedItemsKey), findsOneWidget);

    expect(find.byKey(closeAsnsKey), findsOneWidget);
    Text closeRec = tester.firstWidget(find.byKey(closeAsnsKey));
    expect(closeRec.data, noOfClosedAsnsText);

    //  TODO: add tests for complex widget and other scenarios
    expect(find.byKey(nextAsnStatusKey), findsOneWidget);
    Text nextReception = tester.firstWidget(find.descendant(
      of: find.byType(NextAsnStatusSection),
      matching: find.byType(Text),
    ));
    expect(nextReception.data, nextASNText);

    expect(find.byKey(moreOptionsButtonKey), findsOneWidget);

    //await tester.tap(find.byType(PurchaseOrderCard)); // not a widget
    //expect(find.byKey(const Key("poDetailsPage")), findsOneWidget);
  });
}
