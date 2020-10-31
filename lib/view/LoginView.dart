import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widget/AnnuncioWidget.dart';
import '../model/Annuncio.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: Color(0xfff5f5f5),
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
                      getInputText('email', emailController),
                      SizedBox(height: 25),
                      getInputText('password', passwordController, true),
                      SizedBox(height: 35),
                      getButton('Entra'),
                      SizedBox(height: 40),
                      getLink('Ospite?')
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget getInputText(String placeholder, TextEditingController controller,
      [bool forPwd = false]) {
    return Container(
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Color(0xff444444), fontSize: 20),
        // controller: null,
        decoration: InputDecoration(
            /*suffix: forPwd
                ? FlatButton(
                    minWidth: 10,
                    height: 10,
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Color(0xff444444),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      print('alsdfjkhg');
                    },
                  )
                : null,*/
            border: InputBorder.none,
            hintText: placeholder,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
        obscureText: forPwd,
      ),
      decoration: BoxDecoration(
          color: Color(0xffa4c2f4), borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget getButton(String text) {
    return SizedBox(
        width: double.infinity,
        child: FlatButton(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.normal,
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(vertical: 15),
            color: Color(0xff6d9eeb),
            onPressed: () {
              var email = emailController.text;
              var password = passwordController.text;
            }));
  }

  Widget getLink(String text) {
    return SizedBox(
        width: double.infinity,
        child: FlatButton(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xff1C4587),
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () {
            }));
  }
}
