import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:nock/nock.dart';

void main() {
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

  testWidgets('Import products options', (WidgetTester tester) async {
    nock.get("/brands").reply(200, json.encode({"brands": []}));

    // Build our app and trigger a frame.
    await tester.pumpWidget( const MyApp(intitialRoute: '/variants/import',));

    expect(find.text('Import Products'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton,'Submit'), findsOneWidget);
  });
}
