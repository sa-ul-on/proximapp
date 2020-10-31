import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../util/FormUtils.dart';

class LoginView extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ProximAPP',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2f5597)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 80),
                Form(
                  child: Column(
                    children: [
                      FormUtils.getInputText('email', emailController),
                      SizedBox(height: 25),
                      FormUtils.getInputText(
                          'password', passwordController, true),
                      SizedBox(height: 35),
                      FormUtils.getButton('Entra', () {
                        var email = emailController.text;
                        var password = passwordController.text;
                        Navigator.pushReplacementNamed(context, 'bacheca');
                      }),
                      SizedBox(height: 40),
                      FormUtils.getLink('Ospite?', () {
                        Navigator.pushNamed(context, 'ospite');
                      })
                    ],
                  ),
                ),
              ],
            )));
  }
}
