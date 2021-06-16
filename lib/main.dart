import 'package:crypto_demo/models/crypto-favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_demo/common/theme.dart';
import 'package:crypto_demo/models/cart.dart';
import 'package:crypto_demo/models/catalog.dart';
import 'package:crypto_demo/screens/cart.dart';
import 'package:crypto_demo/screens/catalog.dart';
import 'package:crypto_demo/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),

        ChangeNotifierProvider(create: (context) => CryptoFavorites())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
