import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'dart:math';

void main() => runApp(MyApp());

int _id = 0;

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

enum Constant {
  Settings, Sound, Logout
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Item extends Comparable {
  int id;
  String title;
  bool active;
  Item(this.title) {
    this.id = _id++;
    this.active = true;
  }

  @override
  int compareTo(other) {
    return int.parse(this.title).compareTo(int.parse(other.title));
  }
}
class _MyHomePageState extends State<MyHomePage> {
  List<Constant> choices = [Constant.Logout, Constant.Settings, Constant.Sound];
  List<Item>     items   = [];
  List<Tag>      tags    = [];

  TextEditingController controller = TextEditingController();
  String filter;
//  double _width = 50;
  double _height = 0;
  Color _color = Colors.green;
//  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  InkWell _inkWell(int index)
  {
    return InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute())); }, child: _card(index));
  }

  Card _card(int index)
  {
    return Card(child: Padding(padding: const EdgeInsets.all(16.0), child: Text(items[index].title)));
  }

  bool _contains(int index)
  {
    return filter == null || filter == "" || items[index].title.toLowerCase().contains(filter.toLowerCase());
  }

  List<PopupMenuEntry> _popupMenuBuilder(Tag tag)
  {
    return <PopupMenuEntry>[
      PopupMenuItem(
        child: Text(tag.title, style: TextStyle(color: Colors.blue)),
        enabled: false,
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: <Widget>[
            Icon(Icons.content_copy),
            Text("Copy text"),
          ],
        ),
      ),
    ];
  }

  void _getActiveTags()
  {
    tags.where((tag) => tag.active).forEach((tag) => print(tag.title));
  }

  void _getDisableTags()
  {
    tags.where((tag) => !tag.active).forEach((tag) => print(tag.title));
  }

  void choiceAction(Constant choice) {
    print(choice.toString().substring(9));
  }

  @override
  initState() {
    super.initState();
    for (int i = 1; i <= 20; i++) items.add(Item(i.toString()));
//    items.add(Item("Apple"));
//    items.add(Item("Bananas"));
//    items.add(Item("Milk"));
//    items.add(Item("Water"));
    items.forEach((item) =>
        tags.add(
            Tag(
              id: item.id,
              title: item.title,
              active: item.active,
            )
        )
    );
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
              return choices.map((Constant choice) {
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
          child: PageView(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Flexible(
              Container(
                child: AnimatedContainer(
                  width: MediaQuery.of(context).size.width,
                  height: _height,
                  decoration: BoxDecoration(
                    color: _color,
//                  borderRadius: _borderRadius,
                  ),
                  // Define how long the animation should take.
                  duration: Duration(seconds: 1),
                  // Provide an optional curve to make the animation feel smoother.
                  curve: Curves.fastOutSlowIn,
                  child: SelectableTags(
                    tags: tags,
                    columns: 3, // default 4
                    symmetry: true, // default false
                    popupMenuBuilder: _popupMenuBuilder,
                    popupMenuOnSelected: (int id, Tag tag){
                      switch(id){
                        case 1:
                          Clipboard.setData(ClipboardData(text: tag.title));
                          break;
                        case 2:
                          setState(() {
                            tags.remove(tag);
                          });
                      }
                    },
                    onPressed: (tag) {
                      if (!tag.active) {
                        items.removeWhere((item) => item.title == tag.title);
                      } else {
                        items.add(Item(tag.title));
                      }
                      print(tag);
                      items.sort();
                      print(items.length);
                      setState(() { });
                    },
                  ),
                ),
              ),
//              Flexible(
              ListView(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Search something",
                        prefixIcon: Icon(Icons.search),
                      ),
                      controller: controller,
                    ),
                    ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _contains(index) ? _inkWell(index) : Container();
                        },
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(0.0),
                        shrinkWrap: true
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            final random = Random();
//            _width = random.nextInt(300).toDouble();
            _height = _height == 0 ? MediaQuery.of(context).size.height : 0;
            _color = Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            );
//             _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
      ),
    );
  }
}