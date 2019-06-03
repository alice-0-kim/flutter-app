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
//      home: Button(),
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
              Padding(padding: EdgeInsets.only(bottom: 30.0)),
              RaisedButton(
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
  List<Constant> choices = [Constant.Logout, Constant.Settings, Constant.Sound];
  List<String>   items   = [];
  TextEditingController controller = TextEditingController();
  String filter;

  Card _card(int index) {
    return Card(child: Padding(padding: const EdgeInsets.all(16.0), child: Text(items[index])));
  }

  bool _contains(int index) {
    return filter == null || filter == "" || items[index].toLowerCase().contains(filter.toLowerCase());
  }

  void choiceAction(Constant choice) {
    print(choice.toString().substring(9));
  }


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
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Search something",
                    prefixIcon: Icon(Icons.search),
                  ),
                  controller: controller,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _contains(index) ? _card(index) : Container();
                  },
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(0.0),
                ),
                flex: 4,
              ),
              Text("Made with ♥️ by Team"),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
            ],
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/
    );
  }
}

enum Constant {
  Settings, Sound, Logout
}