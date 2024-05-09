import 'package:flutter/material.dart';
import 'package:frontend/widgets/web_view_page.dart';
import 'package:webviewx/webviewx.dart';

import '../themes/base_theme.dart';
import 'dashboard_drawer.dart';

class Dashboard extends StatelessWidget {
  final GlobalKey<WebViewXPageState> _key = GlobalKey();
  final String loggedUserName;
  Dashboard({super.key, required this.loggedUserName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.grey.withOpacity(0),
      drawer: WebViewAware(
        child: DashboardDrawer(
          loggedUserName: loggedUserName,
          webviewKey: _key,
          minWidth: drawerMinWidth,
          maxWidth: drawerMaxWidth,
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(start: drawerMinWidth),
        child: WebViewXPage(
          initialSource: "",
          sourceType: SourceType.url,
          key: _key,
        ),
      ),
    );
  }
}
