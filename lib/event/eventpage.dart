import 'package:flutter/material.dart';
import 'package:generic_app/activity/activitypage.dart';
import 'package:firebase_database/firebase_database.dart';  

final databaseReference = FirebaseDatabase.instance.reference();



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Route _eventRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EventPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.fastLinearToSlowEaseIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  var list = ["1", "2", "3", "4", "5"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNav(),
        appBar:
            AppBar(title: Text('Events'), backgroundColor: Color(0xFF455a64)),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Center(
            child: new ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[for (var item in list) _showActivity(item)],
            ),
          ),
        ),
        backgroundColor: Color(0xFF455a64),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    'Options',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Color(0xFF455a64)),
              ),
              ListTile(
                leading: Icon(Icons.account_box),
                title: Text(
                  'Account',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(
                  'Help & Feedback',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showActivity(String item) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(_eventRoute());
      },
      child: new Container(
        margin: const EdgeInsets.all(10),
        child: Material(
          color: Colors.grey.shade100,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: <Widget>[
              Container(
                  padding: new EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Event $item",
                        style: TextStyle(fontSize: 25),
                      ),
                      new Text(
                        "1 volunteer(s) needed",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //backgroundColor: Colors.blue[100],
      onTap: onTabTapped, // new
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.explore),
          title: new Text('Explore'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.mail),
          title: new Text('Messages'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile')),
      ],
    );
  }

  void onTabTapped(int index) {
    _currentIndex = index;
  }
}
