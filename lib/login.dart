import 'package:flutter/material.dart';
import 'package:flask_hit/login_page.dart';

//void main() => runApp(new MyApp());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return new MaterialApp(
    //   title: 'TheGorgeousLogin',
    //   debugShowCheckedModeBanner: false,
    //   // theme: new ThemeData(
    //   //   primarySwatch: Colors.blue,
    //   // ),
    //   home: new LoginPage(),
    // );
    return Scaffold(body: LoginPage());
  }
}
