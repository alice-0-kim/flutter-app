import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'routes.dart';

enum Choice {
  Settings, Sound, Logout
}

enum Level {
  K8, High, Univ, SAT
}

int _id = 0;

List<Item> items = [];
//List<Tag>  tags  = [];

List<Choice> _choices = [Choice.Logout, Choice.Settings, Choice.Sound];

List<PopupMenuItem<Choice>> popupMenuItems() => _choices.map((choice) { return PopupMenuItem<Choice>(value: choice, child: Text(choice.toString().split('.').last),);}).toList();

void choiceAction(Choice choice) => print(choice.toString().split('.').last);

PopupMenuButton<Choice> popupMenuButton() => PopupMenuButton<Choice>(onSelected: choiceAction, itemBuilder: (BuildContext context) { return popupMenuItems(); },);

class Item extends Comparable {
  int id;
  String title;
  Level level;
  bool active;
  List<Tag> tags = [];

  Item(this.title, this.level) {
    this.id = _id++;
    this.active = true;
  }

  void addTag(Tag tag) {
    tags.add(tag);
  }

  bool containsTag(Tag tag) {
    return tags.contains(tag);
  }

  bool isActive(List<Tag> activeTags) {
    return activeTags.any((tag) => tags.contains(tag));
  }

  @override
  int compareTo(other) {
    return int.parse(this.title).compareTo(int.parse(other.title));
  }
}

class LevelsPage extends StatefulWidget {
  LevelsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          popupMenuButton(),
        ],
      ),
      body: Container(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LevelRoute(title: "K - 8th Grade", tag: "K8", level: Level.K8,)));
                    },
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: "K8",
                          child: Icon(Icons.airport_shuttle),
                        ),
                        Text("K-8"),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(2.5)),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LevelRoute(title: "9 - 12th Grade", tag: "912", level: Level.High,)));
                    },
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: "912",
                          child: Icon(Icons.airport_shuttle),
                        ),
                        Text("9-12"),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(2.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LevelRoute(title: "SAT", tag: "SAT", level: Level.SAT,)));
                    },
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: "SAT",
                          child: Icon(Icons.airport_shuttle),
                        ),
                        Text("SAT"),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(2.5)),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LevelRoute(title: "University", tag: "Univ", level: Level.Univ,)));
                    },
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: "Univ",
                          child: Icon(Icons.airport_shuttle),
                        ),
                        Text("Univ"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class BrowsePage extends StatefulWidget {
  BrowsePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
//  List<Item> items = [];
  List<Tag>  tags  = [];

  TextEditingController controller = TextEditingController();
  String filter;

//  InkWell _inkWell(Card card) {
//    return InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute())); }, child: card);
//  }

  Card _card(int index) {
    return Card(child: Padding(padding: const EdgeInsets.all(16.0), child: Text(items[index].title)));
  }

  bool _contains(int index) {
    return filter == null || filter == "" || items[index].title.toLowerCase().contains(filter.toLowerCase());
  }

  bool _isActive(int index) {
    return items[index].isActive(_getActiveTags());
  }

  List<Tag> _getActiveTags() {
    return tags.where((tag) => tag.active).toList();
  }

//  void updateActiveItems() {
//    activeItems = items.where((item) => item.isActive(_getActiveTags())).toList();
//    activeItems.sort();
//    setState(() { });
//  }

  void _initItems() {
    items = [];
    Item item1 = Item("K-8 1", Level.K8);
    item1.addTag(tags[0]);
    Item item2 = Item("K-8 2", Level.K8);
    Item item3 = Item("K-8 3", Level.K8);
    Item item4 = Item("High 1", Level.High);
    item4.addTag(tags[1]);
    Item item5 = Item("High 2", Level.High);
    item5.addTag(tags[2]);
    Item item6 = Item("High 3", Level.High);
    Item item7 = Item("Univ 1", Level.Univ);
    item7.addTag(tags[3]);
    Item item8 = Item("Univ 2", Level.Univ);
    Item item9 = Item("Univ 3", Level.Univ);
    Item item10 = Item("SAT 1", Level.SAT);
    item10.addTag(tags[4]);
    Item item11 = Item("SAT 2", Level.SAT);
    Item item12 = Item("SAT 3", Level.SAT);
    items.addAll([item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12]);
  }

  void _initTags() {
    tags.add(Tag(id: 0, title: "algebra", active: false));
    tags.add(Tag(id: 1, title: "differentiation",  active: false));
    tags.add(Tag(id: 2, title: "integration",  active: false));
    tags.add(Tag(id: 3, title: "calculus Ⅱ",  active: false));
    tags.add(Tag(id: 4, title: "important",  active: false));
  }

  @override
  initState() {
    super.initState();

    _initTags();
    _initItems();

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
          popupMenuButton(),
        ],
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Search something",
                  prefixIcon: Icon(Icons.search),
                ),
                controller: controller,
              ),
              Container(
                child: SelectableTags(
                  activeColor: Colors.blueAccent,
                  tags: tags,
                  onPressed: (tag) { setState(() {}); },
                ),
              ),
              ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return _contains(index) && _isActive(index) ? InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute(items[index]))); }, child: _card(index)) : Container();
                },
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0.0),
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

}