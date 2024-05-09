import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/model/product.dart';
import 'package:frontend/model/variant.dart';
import 'package:frontend/view/variant_view_popup.dart';

void main() async {
  group('ProductDetailPage', () {
    setUpAll(() async {
      // Load .env file
      TestWidgetsFlutterBinding.ensureInitialized();
      dotenv.testLoad(fileInput: "assets/.env");
    });

    testWidgets('Variant Details view', (WidgetTester tester) async {
      Product product = Product(
          name: 'Product Test',
          brandId: 1,
          supplier: 'test',
          type: 'test',
          family: 'Cloth');

      Variant variant = Variant(
          product: product,
          sku: 'SKU',
          barcode: 'Barcode',
          variantDescription: 'Variant Description',
          composition: 'Composition',
          hscode: "9999999",
          country: 'Country',
          width: 10,
          height: 10,
          depth: 10,
          weight: 10,
          currency: 'Currency',
          isArchived: false);

      expect(find.text('Product Test'), findsNothing);
      expect(find.text('Cloth'), findsNothing);

      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: VariantViewPopup(variant: variant),
      ));

      expect(find.text('Product Test'), findsNWidgets(2));
      expect(find.text('Cloth'), findsOneWidget);
    });
  });
}
