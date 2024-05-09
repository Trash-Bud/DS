import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/controller/providers/brands_provider.dart';
import 'package:frontend/controller/providers/products_provider.dart';
import 'package:frontend/view/common/utils.dart';
import 'package:frontend/view/import_products_page.dart';
import 'package:frontend/view/variants_page/variants_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String intitialRoute;

  const MyApp({super.key, this.intitialRoute = '/'});

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider = ProductsProvider();
    final BrandsProvider brandsProvider = BrandsProvider();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => productsProvider),
          ChangeNotifierProvider(create: (_) => brandsProvider),
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Maersk',
            theme: ThemeData(
              fontFamily: 'TitilliumWeb',
              primarySwatch: Colors.blue,
            ),
            initialRoute: intitialRoute,
            routes: {
              '/': (context) {
                onStartup(context, productsProvider);
                return const VariantsPage();
              },
              VariantsPage.route: (context) => const VariantsPage(),
              ImportPage.route: (context) => const ImportPage(),
            },
          );
        });
  }

  onStartup(BuildContext context, ProductsProvider productsProvider) {
    productsProvider.getVariants().then((success) {
      if (!success) {
        showStandardDialog(context, 'Information', 'Failed to load variants!');
      }
    });
  }
}
