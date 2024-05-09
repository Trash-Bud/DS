import 'package:flutter/material.dart';
import 'package:frontend/model/entities/purchase_order.dart';
import 'package:frontend/view/pages/asn_details.dart';
import 'package:frontend/view/pages/kafka_received_reception_created.dart';
import 'package:frontend/view/pages/kafka_received_reception_received.dart';
import 'package:frontend/view/pages/kafka_send.dart';
import 'package:frontend/view/pages/po_details.dart';
import 'package:frontend/view/pages/main_page.dart';

import '../model/entities/asn.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        if (args == null) {
          return MaterialPageRoute(builder: (_) => const PoPage());
        }
        if (args is! int) return _errorRoute();
        if (args < 0 || args > 0) return _errorRoute();
        return MaterialPageRoute(builder: (_) => PoPage(index: args));

      case "/purchase-order":
        if (args is List<dynamic>) {
          if (args[0] is! PurchaseOrder || args[1] is! int) {
            return _errorRoute();
          }
          final PurchaseOrder po = args[0];
          if (args[1] < 0 || args[1] >= po.asns.length) return _errorRoute();
          return MaterialPageRoute(
              builder: (_) => PoDetails(data: args[0], index: args[1]));
        }
        if (args is! PurchaseOrder) return _errorRoute();
        return MaterialPageRoute(builder: (_) => PoDetails(data: args));

      case "/asn":
        if (args is! Asn) return _errorRoute();
        return MaterialPageRoute(builder: (_) => ASNDetails(data: args));

      case "/kafka/received/reception-created":
        return MaterialPageRoute(
            builder: (_) => const KafkaReceivedReceptionCreated());

      case "/kafka/received/reception-received":
        return MaterialPageRoute(
            builder: (_) => const KafkaReceivedReceptionReceived());

      case "/kafka/send/reception-received":
        return MaterialPageRoute(builder: (_) => const KafkaSend());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(body: Center(child: Text('404:PageNotFound')));
    });
  }
}
