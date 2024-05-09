// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/dashboard_item.dart';
import 'package:frontend/login_page.dart';
import 'package:frontend/themes/base_theme.dart';
import 'package:frontend/widgets/collapsible_text_button_icon.dart';
import 'package:frontend/widgets/dashboard_drawer.dart';

import 'package:frontend/widgets/web_view_page.dart';
import 'package:webviewx/webviewx.dart';

void main() {
  testWidgets('Find WebView Component', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.runAsync(() async {
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
        body: Padding(
          padding: EdgeInsetsDirectional.only(start: 40),
          child: WebViewXPage(
            initialSource: '<h1>Test</h1>',
            sourceType: SourceType.html,
          ),
        ),
      )));

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('webviewx')), findsWidgets);
    });
  });

  testWidgets('Login Page displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: LoginPage(
      emblem: SizedBox(),
    )));

    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Username or email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  group('DashboardDrawer', () {
    testWidgets('Services are loaded using JSON', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                DashboardDrawer(
                    loggedUserName: "", servicesJson: Future<String>.value('''
[
  {
    "icon": "61484",
    "fontFamily": "FontAwesomeSolid",
    "fontPackage": "font_awesome_flutter",
    "name": "Catalog",
    "url": "localhost:3000"
  },
  {
    "icon": "62069",
    "fontFamily": "FontAwesomeSolid",
    "fontPackage": "font_awesome_flutter",
    "name": "Inbound",
    "url": "localhost:3001"
  }
]'''), emblem: const SizedBox(), logo: const SizedBox()),
              ],
            ),
          ),
        ),
      );

      final DashboardDrawerState state =
          tester.state(find.byType(DashboardDrawer));

      expect(state.items.length, 2);

      expect(
        state.items[0].icon,
        const IconData(
          61484,
          fontFamily: "FontAwesomeSolid",
          fontPackage: "font_awesome_flutter",
        ),
      );
      expect(state.items[0].name, "Catalog");
      expect(state.items[0].url, "localhost:3000");

      expect(
        state.items[1].icon,
        const IconData(
          62069,
          fontFamily: "FontAwesomeSolid",
          fontPackage: "font_awesome_flutter",
        ),
      );
      expect(state.items[1].name, "Inbound");
      expect(state.items[1].url, "localhost:3001");
    });

    testWidgets('Drawer opens when clicking chevron', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                DashboardDrawer(
                  loggedUserName: "",
                  servicesJson: Future<String>.value('''
[
  {
    "icon": "61484",
    "fontFamily": "FontAwesomeSolid",
    "fontPackage": "font_awesome_flutter",
    "name": "Catalog",
    "url": "localhost:3000"
  },
  {
    "icon": "62069",
    "fontFamily": "FontAwesomeSolid",
    "fontPackage": "font_awesome_flutter",
    "name": "Inbound",
    "url": "localhost:3001"
  }
]'''),
                  emblem: const Icon(FontAwesomeIcons.a),
                  logo: const Text("Logo"),
                  animationDuration: Duration.zero,
                  maxWidth: 260,
                  minWidth: 70,
                ),
              ],
            ),
          ),
        ),
      );

      final drawerFinder = find.byType(DashboardDrawer);
      final DashboardDrawerState state = tester.state(drawerFinder);

      final chevronFinder = find.byKey(const Key("drawer-chevron"));
      await tester.tap(chevronFinder);
      await tester.pump();

      expect(state.open, true);
      expect(find.text("Catalog"), findsOneWidget);
      expect(find.text("Inbound"), findsOneWidget);
      expect(find.text("Logo"), findsOneWidget);
      expect((tester.widget<IconButton>(chevronFinder).icon as Icon).icon,
          FontAwesomeIcons.chevronLeft);
      expect(
          tester
              .widget<Container>(find.byKey(const Key("dashboard-drawer")))
              .constraints
              ?.widthConstraints()
              .minWidth,
          260);

      await tester.tap(chevronFinder);
      await tester.pump();

      expect(state.open, false);
      expect(find.text("Catalog"), findsNothing);
      expect(find.text("Inbound"), findsNothing);
      expect(find.text("Logo"), findsNothing);
      expect((tester.widget<IconButton>(chevronFinder).icon as Icon).icon,
          FontAwesomeIcons.chevronRight);
      expect(
          tester
              .widget<Container>(find.byKey(const Key("dashboard-drawer")))
              .constraints
              ?.widthConstraints()
              .minWidth,
          70);
      return;
    });

    testWidgets('Drawer Switching Services', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: baseTheme,
          home: Scaffold(
            body: Stack(
              children: [
                DashboardDrawer(
                  loggedUserName: "",
                  servicesJson: Future<String>.value('''
[
  {
    "icon": "61484",
    "fontFamily": "FontAwesomeSolid",
    "fontPackage": "font_awesome_flutter",
    "name": "Catalog",
    "url": "localhost:3000"
  },
  {
    "icon": "62069",
    "fontFamily": "FontAwesomeSolid",
    "fontPackage": "font_awesome_flutter",
    "name": "Inbound",
    "url": "localhost:3001"
  }
]'''),
                  emblem: const SizedBox(),
                  logo: const SizedBox(),
                  animationDuration: Duration.zero,
                  maxWidth: 260,
                  minWidth: 70,
                ),
              ],
            ),
          ),
        ),
      );

      final drawerFinder = find.byType(DashboardDrawer);
      final DashboardDrawerState state = tester.state(drawerFinder);

      await tester.pump();

      final service1Finder = find.byKey(const Key("service-0-btn"));
      final service2Finder = find.byKey(const Key("service-1-btn"));
      final service1Collapsible = find.descendant(
          of: service1Finder, matching: find.byType(CollapsibleTextButtonIcon));
      final service2Collapsible = find.descendant(
          of: service2Finder, matching: find.byType(CollapsibleTextButtonIcon));

      // TESTING DEFAULT SELECTION
      expect(state.selected, 0);
      expect(
          (tester.widget<CollapsibleTextButtonIcon>(service1Collapsible)).color,
          baseTheme.highlightColor);
      expect(
          (tester.widget<CollapsibleTextButtonIcon>(service2Collapsible)).color,
          isNot(baseTheme.highlightColor));

      await tester.tap(service2Finder);
      await tester.pump();

      expect(state.selected, 1);
      expect(
          (tester.widget<CollapsibleTextButtonIcon>(service2Collapsible)).color,
          baseTheme.highlightColor);
      expect(
          (tester.widget<CollapsibleTextButtonIcon>(service1Collapsible)).color,
          isNot(baseTheme.highlightColor));
    });
  });

  testWidgets('Collapsible Text Button Icon closed', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CollapsibleTextButtonIcon(
            padding: EdgeInsets.zero,
            iconSize: 32,
            icon: const Icon(Icons.abc),
            label: const Text("Button Text"),
            onPressed: () {},
            open: false,
          ),
        ),
      ),
    );

    final labelFinder = find.text("Button Text");
    final iconFinder = find.byIcon(Icons.abc);

    expect(labelFinder, findsNothing);
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Collapsible Text Button Icon open', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CollapsibleTextButtonIcon(
            padding: EdgeInsets.zero,
            iconSize: 32,
            icon: const Icon(Icons.abc),
            label: const Text("Button Text"),
            onPressed: () {},
            open: true,
          ),
        ),
      ),
    );

    final labelFinder = find.text("Button Text");
    final iconFinder = find.byIcon(Icons.abc);

    expect(labelFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Collapsible Text Button Icon onPressed', (tester) async {
    bool pressed = false;

    // testing with closed drawer
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CollapsibleTextButtonIcon(
            key: const Key("Collapsible"),
            padding: EdgeInsets.zero,
            iconSize: 32,
            icon: const Icon(Icons.abc),
            label: const Text("Button Text"),
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key("Collapsible")));

    await tester.pump();
    expect(pressed, true);
    pressed = false;

    // testing with open drawer
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CollapsibleTextButtonIcon(
            key: const Key("Collapsible"),
            padding: EdgeInsets.zero,
            iconSize: 32,
            icon: const Icon(Icons.abc),
            label: const Text("Button Text"),
            onPressed: () {
              pressed = true;
            },
            open: true,
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key("Collapsible")));

    await tester.pump();
    expect(pressed, true);
  });

  test("Dashboard Item JSON loading", () {
    dynamic json = <String, dynamic>{};
    json["name"] = "Catalog";
    json["icon"] = "61484";
    json["fontFamily"] = "FontAwesomeSolid";
    json["fontPackage"] = "font_awesome_flutter";
    json["url"] = "localhost:3000";

    DashboardItem item = DashboardItem.fromJson(json);

    expect(
      item.icon,
      const IconData(
        61484,
        fontFamily: "FontAwesomeSolid",
        fontPackage: "font_awesome_flutter",
      ),
    );
    expect(item.name, "Catalog");
    expect(item.url, "localhost:3000");
  });
}
