import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';


// void main() => runApp(MyApp());

// class Upload extends StatelessWidget {
//   final String phn;
//   Upload(this.phn);
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // title: 'Flutter Demo',
//       // theme: ThemeData(
//       //   // This is the theme of your application.
//       //   //
//       //   // Try running your application with "flutter run". You'll see the
//       //   // application has a blue toolbar. Then, without quitting the app, try
//       //   // changing the primarySwatch below to Colors.green and then invoke
//       //   // "hot reload" (press "r" in the console where you ran "flutter run",
//       //   // or simply save your changes to "hot reload" in a Flutter IDE).
//       //   // Notice that the counter didn't reset back to zero; the application
//       //   // is not restarted.
//       //   primarySwatch: Colors.blue,
//       // ),

//       body: MyHomePage(title: 'Upload Document'),
//     );
//   }
// }

class Upload extends StatefulWidget {
  final String phn;
  Upload(this.phn);


  @override
  _UploadState createState() => _UploadState(this.phn);
}

class _UploadState extends State<Upload> {
  final String phn;
  _UploadState(this.phn);
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadFile(image);

    setState(() {
      _image = image;
    });
  }



  // Methode for file upload
  void _uploadFile(File fileObj) async {
    print("attempting to connect to server……");
var stream = new http.ByteStream(DelegatingStream.typed(fileObj. openRead()));
var length = await fileObj.length();
print(length);
var uri = Uri.parse("http://1dde8979.ngrok.io/file-upload");
print("connection established.");

var request = new http.MultipartRequest("POST", uri)
                  ..fields['no'] = this.phn
                  ..fields['dname'] = 'Aadhaar';
var multipartFile = new http.MultipartFile("file", stream, length,
filename: basename(fileObj.path));
//contentType: new MediaType(‘image’, ‘png’));
request.files.add(multipartFile);

var response = await request.send();
print(response.statusCode);
final x = await response.stream.bytesToString();
       print("Response :  $x");
//     fileObj =await fileObj.rename('file');
//     var stream = new http.ByteStream(DelegatingStream.typed(fileObj.openRead()));
//       // get file length
//       var length = await fileObj.length();
      
//     // Get base file name
//     var fileContent = fileObj.readAsBytesSync();
// var fileContentBase64 = base64.encode(fileContent);     

//     String fileName = basename(fileObj.path);
//     print("File base name: $fileObj");
//     Map<String, String> headers = {"Content-type": "multipart/form-data"};

//     try {
//       // FormData formData =
//       //     new FormData.from({"file": new UploadFileInfo(filePath, fileName)});
//      var request = http.MultipartRequest("POST", Uri.parse("http://d72d417a.ngrok.io/file-upload"));

//      request.files.add(new http.MultipartFile("file", stream, length));
//      var response = await request.send();
//       // var response =
//       //     //await Dio().post("http://f83bf7f4.ngrok.io", data: formData);
//       //     await http.post("http://c9bbf99d.ngrok.io/file-upload",headers:headers, body: {'file' : fileContentBase64});
//       if(response == null)
//       {
//         print('no response');
//       }
      
//       print("File upload response: $response");
//       final x = await response.stream.bytesToString();
//       print("Response :  $x");

//       // Show the incoming message in snakbar
    
//     } catch (e) {
//       print("Exception Caught: $e");
//     }
  }

  // Method for showing snak bar message
  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldstate,
     
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}