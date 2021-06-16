import 'package:crypto_demo/screens/catalog.dart';
import 'package:crypto_demo/screens/crypto.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class DrawerTemplate extends StatelessWidget {
  const DrawerTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDrawer(children: [
      DrawerItem(
        icon: Icons.history,
        title: "Catalog",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => MyCatalog(),
            ),
          );
        },
      ),
      DrawerItem(
        icon: Icons.history,
        title: "Crypto",
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => MyCrypto(),
            ),
          );
        },
      )
    ]);
  }
}
