import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF455a64),
      appBar: AppBar(title: Text('Events'), backgroundColor: Color(0xFF455a64)),
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
                        children: <Widget>[
                          new Text(
                            "Cricket activities",
                            style: new TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  "Volunteer for a fun day of Cricket!",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),    
              _showActivity(),
              _showActivity(),
              _showActivity(),
              _showActivity(),
              _showActivity(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showActivity() {
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
            children: <Widget>[
              Container(
                  padding: new EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Activity 1",
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
