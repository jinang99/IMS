import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flask_hit/login.dart';
//import 'package:camera/camera.dart';

//List<CameraDescription> cameras;

Future<Null> main() async {
  //cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "IdentifyEasy",
      theme: new ThemeData(
        primaryColor: new Color(0xff045791),
        accentColor: new Color(0xff25D366),
      ),
      debugShowCheckedModeBanner: false,
      home: new Login(),
    );
  }
}
