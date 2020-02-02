import 'package:flask_hit/upload.dart';
import 'package:flutter/material.dart';
import './search.dart';
import './request.dart';
import './files.dart';

class TabView extends StatefulWidget {
  final String phn;
  TabView(this.phn);
  @override
  _TabViewState createState() => _TabViewState(this.phn);
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin{
  final phn;
  _TabViewState(this.phn);
 TabController _tabController;
  String role = 'User';
  void initState()
  {
    super.initState();
     _tabController = new TabController(vsync: this, initialIndex: 1, length: 2);
  }

   Widget build(BuildContext context) {
     return new Scaffold(
       appBar: new AppBar(
          title: new Text("IdentifyEasy"),
          //centerTitle: true,
          elevation: 0.7,
          bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              (role == 'User') ?
              new Tab(text: 'Upload'):
              new Tab(text: 'Search'),
              (role == 'User') ?
              new Tab(text: 'Request'):
              new Tab (text: 'Files')
              
            ],
       
     )
     ),
     body: WillPopScope(
          onWillPop: () async {
            return Future.value(
                false); //return a `Future` with false value so this route cant be popped or closed.
          },
          child: new TabBarView(
            controller: _tabController,
            children: <Widget>[
              //new CameraScreen()
              (role == "User") ? new Upload(this.phn) : Search(),
              // new StatusScreen(),
              (role == "User") ? new Request(this.phn) : Files()
            ],
          ),
          // floatingActionButton: new FloatingActionButton(
          //   backgroundColor: Theme.of(context).accentColor,
          //   child: new Icon(
          //     Icons.message,
          //     color: Colors.white,
          //   ),
          //   onPressed: () => print("open chats"),
          // ),
        ),
     );
   }
}


