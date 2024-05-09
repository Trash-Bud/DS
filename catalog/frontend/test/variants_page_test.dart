import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/model/brand.dart';
import 'package:nock/nock.dart';

import 'package:frontend/main.dart';

void main() async {
  group('ProductsPage', () {
    setUpAll(() async {
      // Load .env file
      TestWidgetsFlutterBinding.ensureInitialized();
      dotenv.testLoad(fileInput: "assets/.env");

      // Reply to all requests with a mock response
      nock.defaultBase =
          dotenv.get("BACKEND_URL", fallback: "http://localhost:8080");
      nock.init();
    });

    setUp(() {
      // Reset the state of all nock mocks.
      nock.cleanAll();
    });

    testWidgets('Variants page title smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      expect(find.text('Variants List'), findsOneWidget);
    });

    testWidgets('New Variant Properties show up online',
        (WidgetTester tester) async {
      Brand fakeBrand = Brand(id: 1, name: "Fake");

      // Return success when retrieving products list
      nock.get("/products").reply(200, json.encode({"products": []}));
      nock.get("/brands").reply(
          200,
          json.encode({
            "brands": [fakeBrand]
          }));
      nock.get("/variants/pages").reply(200, json.encode({"pages": 1}));
      nock
          .get("/variants?pageNumber=1")
          .reply(200, json.encode({"variants": []}));

      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Failed to load brands!'), findsNothing);
      expect(find.text('Failed to load products!'), findsNothing);
      expect(find.text('Failed to load variants!'), findsNothing);

      // tap dropdown
      await tester.tap(find.byType(DropdownButton<Brand>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Fake').last);
      await tester.pumpAndSettle();

      expect(find.text('Variant Properties'), findsNothing);
      await tester.tap(find.text('Create Variant'));
      await tester.pump();
      expect(find.text('Variant Properties'), findsOneWidget);
    });

    testWidgets('Error shows up offline', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Failed to load variants!'), findsOneWidget);
      expect(find.text('Failed to load brands!'), findsOneWidget);
    });
  });
}
