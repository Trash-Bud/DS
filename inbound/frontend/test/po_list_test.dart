import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/controller/provider/purchase_order_change_notifier.dart';
import 'package:frontend/controller/repository/asn_repository.dart';
import 'package:frontend/controller/repository/purchase_order_repository.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/model/po_status.dart';
import 'package:frontend/view/pages/main_page.dart';
import 'package:frontend/view/widgets/po_card/more_options_button_po.dart';
import 'package:frontend/view/widgets/po_card/po_card_small.dart';
import 'package:frontend/view/widgets/po_card/received_items_chip.dart';
import 'package:frontend/view/widgets/po_list_navbar/po_nav_bar.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'po_list_test.mocks.dart';

@GenerateMocks([PurchaseOrderRepository])
@GenerateMocks([AsnRepository])
void main() {
  var purchaseOrderRepositoryMock = MockPurchaseOrderRepository();
  var asnRepositoryMock = MockAsnRepository();

  final purchaseOrders = [
    PurchaseOrder(
        id: 1,
        poIdentification: "PO#2020-6010",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Store",
        receivedItems: 0,
        totalItems: 523,
        status: PoStatus.open,
        asns: []),
    PurchaseOrder(
        id: 2,
        poIdentification: "PO#2020-6020",
        name: "AW2444_Arzella_1",
        supplier: "Cousin of Arzelland Vintage Store",
        receivedItems: 800,
        totalItems: 3100,
        status: PoStatus.cancelled,
        asns: []),
    PurchaseOrder(
        id: 3,
        poIdentification: "PO#2020-6030",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Supply",
        receivedItems: 0,
        totalItems: 523,
        status: PoStatus.open,
        asns: []),
    PurchaseOrder(
        id: 4,
        poIdentification: "PO#2020-6048",
        name: "AW2444_Arzella_1",
        supplier: "Cousin of Arzelland Vintage Supply",
        receivedItems: 800,
        totalItems: 3100,
        status: PoStatus.cancelled,
        asns: []),
    PurchaseOrder(
        id: 5,
        poIdentification: "PO#2020-6050",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Store",
        receivedItems: 0,
        totalItems: 523,
        status: PoStatus.open,
        asns: []),
    PurchaseOrder(
        id: 6,
        poIdentification: "PO#2020-6060",
        name: "AW2444_Arzella_1",
        supplier: "Cousin of Arzelland Vintage Supply",
        receivedItems: 800,
        totalItems: 3100,
        status: PoStatus.cancelled,
        asns: []),
    PurchaseOrder(
        id: 7,
        poIdentification: "PO#2020-6070",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Supply",
        receivedItems: 0,
        totalItems: 523,
        status: PoStatus.open,
        asns: []),
    PurchaseOrder(
        id: 7,
        poIdentification: "PO#2020-6080",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Supply",
        receivedItems: 0,
        totalItems: 523,
        status: PoStatus.open,
        asns: []),
    PurchaseOrder(
        id: 7,
        poIdentification: "PO#2020-6090",
        name: "AW1819_Arzella_1",
        supplier: "Arzelland Vintage Store",
        receivedItems: 0,
        totalItems: 523,
        status: PoStatus.open,
        asns: []),
  ];

  void getPurchaseOrders() {
    when(purchaseOrderRepositoryMock.getPurchaseOrders(
            textQuery: "", poState: "", offset: 0, limit: 5))
        .thenAnswer(
            (_) async => {"purchaseOrders": purchaseOrders, "totalResults": 5});
  }

  void getPurchaseOrdersSecPage() {
    when(purchaseOrderRepositoryMock.getPurchaseOrders(
            textQuery: "", poState: "", offset: 5, limit: 5))
        .thenAnswer((_) async => {
              "purchaseOrders": purchaseOrders.sublist(5, 10),
              "totalResults": 5
            });
  }

  void getAsns() {
    when(asnRepositoryMock.getAsns(
            textQuery: "", asnState: "", offset: 0, limit: 5))
        .thenAnswer((_) async => {"asns": <Asn>[], "totalResults": 0});
  }

  Widget createWidgetUnderTest() {
    return MediaQuery(
        data: const MediaQueryData(size: Size(700, 700)),
        child: MaterialApp(
            home: MultiProvider(providers: [
          ChangeNotifierProvider(
              create: (_) =>
                  PurchaseOrderChangeNotifier(purchaseOrderRepositoryMock)),
          ChangeNotifierProvider(
              create: (_) => AsnChangeNotifier(asnRepositoryMock, purchaseOrderRepositoryMock))
        ], child: const PoPage())));
  }

  testWidgets('Test PO list page', (WidgetTester tester) async {
    getPurchaseOrders();
    getPurchaseOrdersSecPage();
    getAsns();

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Testing the small list (small screen cards)

    Text name = tester.firstWidget(find.descendant(
      of: find.byType(PoNavBar),
      matching: find.text("POs"),
    ));
    expect(name.data, "POs");

    expect(find.byType(TextField), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    final colorScheme = find.byType(ColorCaption);
    expect(colorScheme, findsOneWidget);

    final poCards = find.byType(PoCardSmall);

    expect(poCards, findsNWidgets(2));

    Text name1 = tester.firstWidget(find.descendant(
      of: find.byType(PoCardSmall).first,
      matching: find.text("AW1819_Arzella_1"),
    ));
    expect(
        name1.data, "AW1819_Arzella_1"); //TODO: add keys to remove redundancy

    Text name2 = tester.firstWidget(find.descendant(
      of: find.byType(PoCardSmall).last,
      matching: find.text("AW2444_Arzella_1"),
    ));
    expect(name2.data, "AW2444_Arzella_1");

    Text id1 = tester.firstWidget(find.descendant(
      of: find.byType(PoCardSmall).first,
      matching: find.text("PO#2020-6010"),
    ));
    expect(id1.data, "PO#2020-6010");

    Text id2 = tester.firstWidget(find.descendant(
      of: find.byType(PoCardSmall).last,
      matching: find.text("PO#2020-6020"),
    ));
    expect(id2.data, "PO#2020-6020");

    final receivedItemsChip = find.byType(ReceivedItemsChip);
    expect(receivedItemsChip, findsNWidgets(2));

    Text firstChip = tester.firstWidget(find.descendant(
      of: find.byType(ReceivedItemsChip).first,
      matching: find.byType(Text),
    ));

    expect(firstChip.data, "0%");

    Text secondChip = tester.firstWidget(find.descendant(
      of: find.byType(ReceivedItemsChip).last,
      matching: find.byType(Text),
    ));

    expect(secondChip.data, "26%");

    final poSupplier = find.text("From: Arzelland Vintage Store");
    expect(poSupplier, findsOneWidget);
    final poSupplier2 = find.text("From: Cousin of Arzelland Vintage Store");
    expect(poSupplier2, findsOneWidget);

    final moreOptions = find.byType(MoreOptionsButton);
    expect(moreOptions, findsNWidgets(2));

    final pager = find.byType(Pager);
    expect(pager, findsOneWidget);

    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();
    expect(poCards, findsNWidgets(2));
  });
}
