import 'package:flask_hit/accept.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert' as JSON;

class Request extends StatefulWidget {
  final String phn;
  Request(this.phn);
  @override
  _RequestState createState() => _RequestState(this.phn);
}

class _RequestState extends State<Request> {

  final String phn;
  _RequestState(this.phn);

  List<Widget> allRequests = [];
  final databaseReference = FirebaseDatabase.instance.reference();
  void initState()  {
    super.initState();
    // print("attempting to connect to server……");
    // var uri = Uri.parse("http://7ed48e3d.ngrok.io/signup");
    // print("connection established.");

    // var request = new http.MultipartRequest("POST", uri)
    //               ..fields['no'] = this.phn;

    // var response = await request.send();
    // print(response.statusCode);
    // final x = await response.stream.bytesToString();
    // print("Response :  $x");              
    // final json=JSON.jsonDecode(x);
    databaseReference.child('requests').child('$phn').once().then((DataSnapshot snapshot) {
    allRequests.clear();
    String addr, ins_name, dname;
    var value = snapshot.value;
     if(value != null){
       value.forEach((k, v){
        print("YOOOOOOOOOOOO:  $v");
        addr = v['address'];
        ins_name = v['name'];
        dname = v['dname']; 
        setState(() {
          allRequests.add(
            ListCard(addr, ins_name, dname)
          );
          print("Yeh lo $allRequests");
        }); 
       });
     }
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return 
    (allRequests.isNotEmpty)?
    new Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
        scrollDirection: Axis.vertical,
          itemCount: allRequests.length,
          itemBuilder: (context, index) {
            ListCard item = allRequests[index];
            return 
            
            Dismissible(
              key: Key(UniqueKey().toString()),
              
               onDismissed: (direction) {
                 print('Dismissed');
                 setState(() {
                  allRequests.removeAt(index);
                 
                });

                // Then show a snackbar.
                 Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed")));
               },
               background: Container(
                color: Colors.red,
                height: 8,
                ),
               child:
              GestureDetector(
                
                child: Container(child: allRequests[index],),
                onTap: () {
                  
                  print('Tap kiya re bhavaaaaaaaaa');
                  Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Accept(phn, item.address, item.dname)));
                },
              ) 
              );}
    )):
    Container(
      child: Text('Requests'),
      
    )
    ; 
  }
}


class ListCard extends StatelessWidget {
  @override
  ListCard(this.address, this.name, this.dname);
  String address, name, dname;
  Widget build(BuildContext context) {
    return 
    Column(
      children: <Widget>[
        Container(
      
      // onTap: () {
      //   _gotoLocation(lat, lng);
      // },
      
      child: Container(
        width: double.infinity,
        height: 150,
      
          
          child: Material(
              color: Colors.white,
             elevation: 14.0,
            //  borderRadius: BorderRadius.circular(24.0),
                
              shadowColor: Color(0x802196f3),
            
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  // Container(
                  //   width: 180,
                  //   height: 200,
                  //   child: ClipRRect(s
                  //     borderRadius: new BorderRadius.circular(24.0),
                  //     child: Image(
                  //       fit: BoxFit.fill,
                  //       image: NetworkImage(_image),
                  //     ),
                  //   ),
                  // ),
                  
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Institute Name : ${name}', style: TextStyle(fontSize: 16),), 
                      
                      
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Institute Address : ${address}', style: TextStyle(fontSize: 20),),
                      
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Document : ${dname}', style: TextStyle(fontSize: 16),),
                      
                    ),
                    
                  ),
                  
               
                ],
              )),
        ),
      
    ),
    // Container(
    //                 child: SizedBox(
    //                   height: 70,
    //                 ),
    //               )
      ],
      
    );
    
    
  }
}