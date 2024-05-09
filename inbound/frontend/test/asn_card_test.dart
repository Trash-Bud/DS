import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/model/entities/asn.dart';
import 'package:frontend/model/asn_status.dart';
import 'package:frontend/view/widgets/asn_card/asn_card.dart';
import 'package:frontend/view/widgets/asn_card/asn_info_section.dart';

Asn mockASN() {
  return Asn(
      id: 0,
      shippingReference: "test asn",
      warehouse: "test warehouse",
      deliveryDate: DateTime.parse("2020-01-02"),
      carrier: "test carrier",
      cargoType: "Normal",
      shipperContact: "test contract",
      poIdentification: null,
      purchaseOrderDate: DateTime.parse("2020-01-01"),
      status: ASNStatus.received, address: '');
}

void main() {
  ASNCard asnCard = ASNCard(mockASN());

  // TODO: verify if object key is best, although it is not a good distinction
  var asnInfoSectionKey = Key("ASNInfoSection${mockASN().shippingReference}");
  var shippingReferenceKey = Key("ASNNameText${mockASN().shippingReference}");
  const shippingReference = "test asn";
  var warehouseNameKey = Key("warehouseName${mockASN().shippingReference}");
  const warehouseName = "test warehouse";
  var deliveryDateKey = Key("deliveryDate${mockASN().shippingReference}");
  var deliveryDate = DateTime.parse("2020-01-02").toString();
  var carrierNameKey = Key("carrierName${mockASN().shippingReference}");
  var carrierName = "test carrier";
  var cargoTypeKey = Key("cargoType${mockASN().shippingReference}");
  var cargoType = "Normal";
  var purchaseOrderKey = Key("purchaseOrder${mockASN().shippingReference}");
  var purchaseOrder = "No PO associated";

  testWidgets('Test ASN card', (WidgetTester tester) async {
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
                        "ASN Name",
                        "Warehouse",
                        "Delivery Date",
                        "Carrier",
                        "Cargo Type",
                        "Purchase Order",
                        "",
                      ],
                      rows: [
                        asnCard.build(context)
                      ]),
                ),
              ),
            ),
          ),
        ),
      );
    }));

    await tester.pumpAndSettle();


    expect(find.byKey(asnInfoSectionKey), findsOneWidget);

    Text asnShippingReference = tester.firstWidget(find.descendant(
      of: find.byType(ASNInfoSection),
      matching: find.byKey(shippingReferenceKey),
    ));

    expect(asnShippingReference.data, shippingReference);

    expect(find.byKey(warehouseNameKey), findsOneWidget);
    Text warehouseNameText = tester.firstWidget(find.byKey(warehouseNameKey));
    expect(warehouseNameText.data, warehouseName);

    expect(find.byKey(deliveryDateKey), findsOneWidget);
    Text deliveryDateText = tester.firstWidget(find.byKey(deliveryDateKey));
    expect(deliveryDateText.data, deliveryDate);

    expect(find.byKey(carrierNameKey), findsOneWidget);
    Text carrierNameText = tester.firstWidget(find.byKey(carrierNameKey));
    expect(carrierNameText.data, carrierName);

    expect(find.byKey(cargoTypeKey), findsOneWidget);
    Text cargoTypeText = tester.firstWidget(find.byKey(cargoTypeKey));
    expect(cargoTypeText.data, cargoType);

    expect(find.byKey(purchaseOrderKey), findsOneWidget);
    Text purchaseOrderText = tester.firstWidget(find.byKey(purchaseOrderKey));
    expect(purchaseOrderText.data, purchaseOrder);
  });
}
