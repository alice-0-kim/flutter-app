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
  List<String> tags = [];

  Item(this.title) {
    this.id = _id++;
    this.active = true;
  }

  void addTag(String tag) {
    tags.add(tag);
  }

  bool containsTag(String tag) {
    return tags.contains(tag);
  }

  bool isActive(List<Tag> activeTags) {
    return activeTags.any((tag) => tags.contains(tag.title));
  }

  @override
  int compareTo(other) {
    return int.parse(this.title).compareTo(int.parse(other.title));
  }
}
class _MyHomePageState extends State<MyHomePage> {
  List<Constant> choices     = [Constant.Logout, Constant.Settings, Constant.Sound];
  List<Item>     items       = [];
  List<Item>     activeItems = [];
  List<Tag>      tags        = [];

  TextEditingController controller = TextEditingController();
  String filter;
  double _separatorHeight = 100.0;

//  InkWell _inkWell(int index) {
//    return InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute())); }, child: _card(index));
//  }

  InkWell _inkWell(Card card) {
    return InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute())); }, child: card);
  }

  Card _card(int index) {
    return Card(child: Padding(padding: const EdgeInsets.all(16.0), child: Text(activeItems[index].title)));
  }

  Card _separator(int index) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Material(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                splashColor: Colors.pinkAccent,
                highlightColor: Colors.pink,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(activeItems[index].title, textAlign: TextAlign.center,),
//                      padding: EdgeInsets.all(10.0),
//                  margin: EdgeInsets.only(right: 2.5),
                  height: _separatorHeight,
                ),
                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute())); },
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(2.5),),
          Expanded(
            child: Material(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                splashColor: Colors.pinkAccent,
                highlightColor: Colors.pink,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(activeItems[index].title, textAlign: TextAlign.center,),
//                      padding: EdgeInsets.all(10.0),
//                  margin: EdgeInsets.only(left: 2.5),
                  height: _separatorHeight,
                ),
                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute())); },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _contains(int index) {
    return filter == null || filter == "" || activeItems[index].title.toLowerCase().contains(filter.toLowerCase());
  }

  List<Tag> _getActiveTags()
  {
    return tags.where((tag) => tag.active).toList();
  }

  List<Tag> _getDisableTags()
  {
    return tags.where((tag) => !tag.active).toList();
  }

  void choiceAction(Constant choice) {
    print(choice.toString().substring(9));
  }

  void updateActiveItems() {
    activeItems = items.where((item) => item.isActive(_getActiveTags())).toList();
    activeItems.sort();
    setState(() { });
  }

  @override
  initState() {
    super.initState();

    for (int i = 1; i <= 20; i++) {
      Item item = Item(i.toString());
      item.addTag(i % 2 == 0 ? "even" : "odd");
      items.add(item);
    }

    tags.add(Tag(id: 0, title: "even", active: false));
    tags.add(Tag(id: 1, title: "odd",  active: false));
    tags.add(Tag(id: 2, title: "differential calculus",  active: false));
    tags.add(Tag(id: 3, title: "integration",  active: false));
    tags.add(Tag(id: 4, title: "algebra",  active: false));

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
            children: <Widget>[
              Container(
                child: SelectableTags(
                  activeColor: Colors.blueAccent,
                  tags: tags,
//                  popupMenuBuilder: _popupMenuBuilder,
//                  popupMenuOnSelected: (int id, Tag tag){
//                    switch(id){
//                      case 1:
//                        Clipboard.setData(ClipboardData(text: tag.title));
//                        break;
//                      case 2:
//                        setState(() {
//                          tags.remove(tag);
//                        });
//                    }
//                  },
                  onPressed: (tag) { updateActiveItems(); },
                ),
              ),
              ListView(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Search something",
                      prefixIcon: Icon(Icons.search),
                    ),
                    controller: controller,
                  ),
                  ListView.separated(
                    itemCount: activeItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _contains(index) ? _inkWell(_card(index)) : Container();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return (index + 1) % 4 == 0 ? _separator(index) : Container();
                    },
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(0.0),
                    shrinkWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            // TODO: implement onPressed behavior
          });
        },
      ),
    );
  }
}