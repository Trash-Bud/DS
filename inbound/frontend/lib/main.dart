import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:frontend/controller/repository/asn_repository.dart';
import 'package:frontend/controller/repository/purchase_order_repository.dart';
import 'package:frontend/controller/route_generator.dart';
import 'package:frontend/utils/theme.dart';
import 'package:provider/provider.dart';
import 'controller/provider/purchase_order_change_notifier.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PurchaseOrderChangeNotifier(PurchaseOrderRepository.instance)),
        ChangeNotifierProvider(create: (_) => AsnChangeNotifier(AsnRepository.instance, PurchaseOrderRepository.instance)),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inbound Microservice',
      theme: baseTheme,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
