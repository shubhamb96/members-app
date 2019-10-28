import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:generic_app/activity/activitydata.dart';

class EventPage extends StatefulWidget {
  int eventID;
  EventPage(this.eventID);
  @override
  _EventPageState createState() => _EventPageState(this.eventID);
}

final FirebaseDatabase ref = FirebaseDatabase.instance;

class _EventPageState extends State<EventPage> {
  int eventID;
  _EventPageState(this.eventID);
  List<ActivityData> allActivityData;
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;
  Query _activityQuery;

  @override
  void initState() {
    super.initState();
    allActivityData = new List();
    _activityQuery = ref
        .reference()
        .child("Activities")
        .orderByChild("Event")
        .equalTo(eventID);
    _onTodoAddedSubscription =
        _activityQuery.onChildAdded.listen(_onEntryAdded);
    _onTodoChangedSubscription =
        _activityQuery.onChildChanged.listen(_onEntryChanged);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  _onEntryChanged(Event event) {
    var oldEntry = allActivityData.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      allActivityData[allActivityData.indexOf(oldEntry)] =
          ActivityData.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      allActivityData.add(ActivityData.fromSnapshot(event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF455a64),
      appBar:
          AppBar(title: Text('Activities'), backgroundColor: Color(0xFF455a64)),
      body: new Stack(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Column with the event title and address
                    new Expanded(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // children: <Widget>[
                        //   new Text(
                        //     "Cricket activities",
                        //     style: new TextStyle(
                        //         fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
                        //   ),
                        //],
                      ),
                    ),
                  ],
                ),
              ),
              // new Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: new Text(
              //     "Volunteer for a fun day of Cricket!",
              //     style: new TextStyle(fontSize: 20.0, color: Colors.white),
              //     textAlign: TextAlign.justify,
              //   ),
              // ),
              new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: allActivityData.length,
                itemBuilder: (BuildContext context, int index) {
                  return _showActivity(
                    allActivityData[index].name,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showActivity(String activityName) {
    return new GestureDetector(
      onTap: () {
        //Navigator.of(context).pushReplacement(_eventRoute());
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
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: new EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Row(
                    children: <Widget>[
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 250, 0),
                          ),
                          new Text(
                            "$activityName",
                            style: TextStyle(fontSize: 25),
                          ),
                          // new Text(
                          //   "1 volunteer(s) needed",
                          //   style: TextStyle(fontSize: 20),
                          // ),
                        ],
                      ),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new RaisedButton(
                            padding: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            onPressed: () {},
                            child: const Text('Register',
                                style: TextStyle(fontSize: 20)),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
