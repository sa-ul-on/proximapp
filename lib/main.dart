import 'package:flutter/material.dart';

import 'view/BachecaView.dart';

void main() {
  runApp(new MaterialApp(
    title: 'App',
    home: BachecaView(),
    routes: <String, WidgetBuilder>{
      '/bacheca': (BuildContext context) => BachecaView(),
      // '/login': (BuildContext context) => Login(),
    },
  ));
}
