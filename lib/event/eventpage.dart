import 'dart:async';

import 'package:flutter/material.dart';
import 'package:generic_app/activity/activitypage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:generic_app/event/eventdata.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final FirebaseDatabase ref = FirebaseDatabase.instance;

class _HomePageState extends State<HomePage> {
  List<EventData> allEventData;
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;
  Query _todoQuery;

  @override
  void initState() {
    super.initState();
    allEventData = new List();
    _todoQuery = ref.reference().child("Events");
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(_onEntryAdded);
    _onTodoChangedSubscription = _todoQuery.onChildChanged.listen(_onEntryChanged);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  _onEntryChanged(Event event) {
    var oldEntry = allEventData.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      allEventData[allEventData.indexOf(oldEntry)] =
          EventData.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      allEventData.add(EventData.fromSnapshot(event.snapshot));
    });
  }
  
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
            child: new ListView.builder(
              itemCount: allEventData.length,
              itemBuilder: (BuildContext context, int index) {
                return _showActivity(
                  allEventData[index].activity1,
                  allEventData[index].activity2,
                  allEventData[index].eventName,
                  allEventData[index].venue,
                );
              },
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

  Widget _showActivity(
      String activity1, String activity2, String eventName, String venue) {
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
                      // new Text(
                      //   'Activity1 : $activity1',
                      //   style: TextStyle(fontSize: 25),
                      // ),
                      // new Text(
                      //   'Activity2 : $activity2',
                      //   style: TextStyle(fontSize: 25),
                      //),
                      new Text(
                        '$eventName Event',
                        style: TextStyle(fontSize: 25),
                      ),
                      new Text(
                        'Venue : $venue',
                        style: TextStyle(fontSize: 25),
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
