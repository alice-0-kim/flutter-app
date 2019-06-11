import 'package:flutter/material.dart';
import 'levels.dart';
import 'browse.dart';
import 'pop_up_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          buildPopupMenuButton(),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BrowsePage(title: "Browse")));
                  },
                  child: Text('Browse'),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LevelsPage(title: "Levels")));
                  },
                  child: Text('Levels'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
