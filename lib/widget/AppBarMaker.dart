import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AppBar makeAppBar(String title) {
  return AppBar(
      textTheme: TextTheme(
          headline6: TextStyle(color: Color(0xff444444), fontSize: 20)),
      title: Text(title),
      iconTheme: IconThemeData(color: Color(0xff444444)),
      backgroundColor: Color(0xfff5f5f5),
      elevation: 0);
}
