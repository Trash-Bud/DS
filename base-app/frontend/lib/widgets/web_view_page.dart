import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class WebViewXPage extends StatefulWidget {
  final String initialSource;
  final SourceType sourceType;
  const WebViewXPage({
    Key? key,
    required this.initialSource,
    required this.sourceType,
  }) : super(key: key);

  @override
  WebViewXPageState createState() => WebViewXPageState();
}

class WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController webviewController;
  bool _controllerInitialized = false;
  final executeJsErrorMessage =
      'Failed to execute this task because the current content is (probably) URL that allows iframe embedding, on Web.\n\n'
      'A short reason for this is that, when a normal URL is embedded in the iframe, you do not actually own that content so you cant call your custom functions\n'
      '(read the documentation to find out why).';

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    if (_controllerInitialized) webviewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaffold.of(context).openDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            child: _buildWebViewX(),
          ),
        ],
      )),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: widget.initialSource,
      initialSourceType: widget.sourceType,
      height: screenSize.height,
      width: screenSize.width,
      onWebViewCreated: (controller) {
        webviewController = controller;
        _controllerInitialized = true;
      },
      onWebResourceError: ((error) => log("error loading web resource ")),
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) =>
          debugPrint('The page has finished loading: $src\n'),
      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }

  void setUrl(String source) {
    webviewController.loadContent(
      source,
      SourceType.url,
    );
  }

  void setUrlBypass(String source) {
    webviewController.loadContent(
      source,
      SourceType.urlBypass,
    );
  }

  void ignoreAllGestures(bool value) {
    webviewController.setIgnoreAllGestures(value);
  }
}
