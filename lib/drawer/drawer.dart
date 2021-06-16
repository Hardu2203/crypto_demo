import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;
  DrawerItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      leading: Icon(icon),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class AppDrawer extends StatelessWidget {
  final List<DrawerItem> children;
  AppDrawer({required this.children});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: const EdgeInsets.all(16.0),
              child: Text("Header")
              // Image.asset(
              //   LOGO_CIRCLE,
              //   fit: BoxFit.contain,
              // ),
            ),
            if (children != null) ...children
          ],
        ),
      ),
    );
  }
}
