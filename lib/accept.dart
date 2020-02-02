import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Accept extends StatefulWidget {
  final String phn, address, dname ;
  Accept(this.phn, this.address, this.dname);
  @override
  _AcceptState createState() => _AcceptState(this.phn, this.address, this.dname);
}

class _AcceptState extends State<Accept> {
  final String phn, address, dname;
  _AcceptState(this.phn, this.address, this.dname);
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("To allow access enter password"),
          Center(

            child: TextField(
            autofocus: true,
            controller: passwordController,
            decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                           
                          ),
          ),
          ),
          RaisedButton(
            child: Text("Authorize"),
            onPressed: () async {

              print("Input ${passwordController.text}");
              print("attempting to connect to server……");
              var uri = Uri.parse("http://1dde8979.ngrok.io/reqVerify");
              print("connection established.");
              var request = new http.MultipartRequest("POST", uri)
                  ..fields['no'] = this.phn
                  ..fields['pass'] = passwordController.text
                  ..fields['dname'] = this.dname
                  ..fields['ask'] = this.address;
              var response = await request.send();
              print(response.statusCode);
              final x = await response.stream.bytesToString();
              print("Response :  $x");  

            })
          
        ],
      ),
      
      
      
      
    );
  }
}