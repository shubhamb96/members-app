import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events'), backgroundColor: Color(0xFF455a64)),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushReplacement(_eventRoute());
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(10),
                      padding: new EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Text('1'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushReplacement(_eventRoute());
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(10),
                      padding: new EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Text('1'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushReplacement(_eventRoute());
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(10),
                      padding: new EdgeInsets.all(10),
                      color: Colors.red,
                      child: Text('2'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushReplacement(_eventRoute());
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(10),
                      padding: new EdgeInsets.all(10),
                      color: Colors.red,
                      child: Text('2'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
