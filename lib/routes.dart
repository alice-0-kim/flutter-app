import 'package:flutter/material.dart';

class FormulaRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formula Route"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProblemRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ploblem Route"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Hero(
              tag: "Tag 3",
              child: Icon(Icons.mail, size: 50.0,),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class LevelRoute extends StatelessWidget {

  LevelRoute({this.title, this.tag});

  final String title, tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Hero(
                  tag: tag,
                  child: Icon(Icons.airport_shuttle, size: 50.0,),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(title),
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ),
      )
    );
  }
}