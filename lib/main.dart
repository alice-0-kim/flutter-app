import 'package:flutter/material.dart';

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
//      home: new Button(),
    );
  }
}

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
              new Padding(padding: new EdgeInsets.only(bottom: 30.0)),
              new RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back!'),
              ),
            ],
          )
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
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
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

  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
    print("Floating button pressed");
  }

//  int counter = 0;

  void choiceAction(Constant choice) {
    print(choice.toString().substring(9));
  }

  List<Constant> choices = <Constant> [Constant.Logout, Constant.Settings, Constant.Sound];

  List<String> items = <String> [];
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  initState() {
    items.add("Apple");
    items.add("Bananas");
    items.add("Milk");
    items.add("Water");
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<Constant>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return choices.map((Constant choice){
                return PopupMenuItem<Constant>(
                  value: choice,
                  child: Text(choice.toString().split('.').last),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Title", style: new TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
            new Expanded(
              child: new TextField(
                decoration: new InputDecoration(
                    labelText: "Search something"
                ),
                controller: controller,
              ),
            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return filter == null || filter == "" ? new Card(child: new Text(items[index])) : items[index].toLowerCase().contains(filter.toLowerCase()) ? new Card(child: new Text(items[index])) : new Container();
                },
              ),
            ),
            new Padding(padding: new EdgeInsets.only(bottom: 50.0)),
            new RaisedButton(
              child: new Text("Formula", style: new TextStyle(color: Colors.white, fontSize: 20.0)),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormulaRoute()),
                );
              },
              padding: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            ),
            new Padding(padding: new EdgeInsets.all(10.0)),
            new RaisedButton(
              child: new Text("Problem", style: new TextStyle(color: Colors.white, fontSize: 20.0)),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProblemRoute()),
                );
              },
              padding: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            ),
            new Padding(padding: new EdgeInsets.only(bottom: 50.0)),
            new Text("Made with ♥️ by Team")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

enum Constant {
  Settings, Sound, Logout
}