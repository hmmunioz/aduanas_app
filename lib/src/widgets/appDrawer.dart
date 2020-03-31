import 'package:flutter/material.dart';

class DrawerApp extends StatefulWidget {
  DrawerApp({Key key}) : super(key: key);

  @override
  _DrawerAppState createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: getListDrawer(),
    );
  }

  ListTile getItem(Icon icon, String description, String route) {
    return ListTile(
      leading: icon,
      title: Text(description),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  ListView getListDrawer() {
    return ListView(
      children: <Widget>[
        DrawerHeader(child: Text("Bienvenido a Petty")),
        getItem(Icon(Icons.home), "Pagina Principal", "/"),
        getItem(Icon(Icons.settings), "Settings", "/settings"),
        getItem(Icon(Icons.battery_alert), "Battery", "/battery"),
        AboutListTile(
          child: Text("Informacion APP"),
          applicationVersion: "1.1.0",
          applicationIcon: Icon(Icons.adb),
          icon: Icon(Icons.info),
        )
      ],
    );
  }
}
