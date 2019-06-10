import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'routes.dart';
import 'content.dart';

enum Choice {
  Settings, Sound, Logout
}

//enum Level {
//  K8, High, Univ, SAT
//}

//int _id = 0;

List<Content> contents = [];
//List<Tag>  tags  = [];

List<Choice> _choices = [Choice.Logout, Choice.Settings, Choice.Sound];

List<PopupMenuItem<Choice>> popupMenuItems() => _choices.map((choice) { return PopupMenuItem<Choice>(value: choice, child: Text(choice.toString().split('.').last),);}).toList();

void choiceAction(Choice choice) => print(choice.toString().split('.').last);

PopupMenuButton<Choice> popupMenuButton() => PopupMenuButton<Choice>(onSelected: choiceAction, itemBuilder: (BuildContext context) { return popupMenuItems(); },);

//class Item extends Comparable {
//  int id;
//  String title;
//  Level level;
//  bool active;
//  List<Tag> tags = [];
//
//  Item(this.title, this.level) {
//    this.id = _id++;
//    this.active = true;
//  }
//
//  void addTag(Tag tag) {
//    tags.add(tag);
//  }
//
//  bool containsTag(Tag tag) {
//    return tags.contains(tag);
//  }
//
//  bool isActive(List<Tag> activeTags) {
//    return activeTags.any((tag) => tags.contains(tag));
//  }
//
//  @override
//  int compareTo(other) {
//    return int.parse(this.title).compareTo(int.parse(other.title));
//  }
//}

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

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('content').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
//        return _buildList(context, snapshot.data.documents);
        return _buildContainer(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildContainer(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Container(
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
            _buildList(context, snapshot),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.all(5.0),
      shrinkWrap: true,
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProblemRoute(Content(record.title, record.level, record.tags)),
          ),
        );
      },
      child: _card(record),
    );
  }

  Card _card(Record record) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(record.title),
      ),
    );
  }

//  bool _contains(int index) {
//    return filter == null || filter == "" || contents[index].title.toLowerCase().contains(filter.toLowerCase());
//  }
//
//  bool _isActive(int index) {
//    return contents[index].isActive(_getActiveTags());
//  }

//  List<Tag> _getActiveTags() {
//    return tags.where((tag) => tag.active).toList();
//  }

//  void updateActiveItems() {
//    activeItems = items.where((item) => item.isActive(_getActiveTags())).toList();
//    activeItems.sort();
//    setState(() { });
//  }

//  void _initItems() {
//    contents = [];
//    Content item1 = Content("K-8 1", Level.K8);
//    item1.addTag(tags[0]);
//    Content item2 = Content("K-8 2", Level.K8);
//    Content item3 = Content("K-8 3", Level.K8);
//    Content item4 = Content("High 1", Level.High);
//    item4.addTag(tags[1]);
//    Content item5 = Content("High 2", Level.High);
//    item5.addTag(tags[2]);
//    Content item6 = Content("High 3", Level.High);
//    Content item7 = Content("Univ 1", Level.Univ);
//    item7.addTag(tags[3]);
//    Content item8 = Content("Univ 2", Level.Univ);
//    Content item9 = Content("Univ 3", Level.Univ);
//    Content item10 = Content("SAT 1", Level.SAT);
//    item10.addTag(tags[4]);
//    Content item11 = Content("SAT 2", Level.SAT);
//    Content item12 = Content("SAT 3", Level.SAT);
//    contents.addAll([item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12]);
//  }

  void _initTags() {
    tags.add(Tag(id: 0, title: "algebra", active: false));
    tags.add(Tag(id: 1, title: "advanced",  active: false));
    tags.add(Tag(id: 2, title: "basic",  active: false));
    tags.add(Tag(id: 3, title: "calculus",  active: false));
    tags.add(Tag(id: 4, title: "important",  active: false));
  }

  @override
  initState() {
    super.initState();

    _initTags();
//    _initItems();

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
      body: _buildBody(context),
//      body: Container(
//        child: Center(
//          child: ListView(
//            children: <Widget>[
//              TextField(
//                decoration: InputDecoration(
//                  labelText: "Search something",
//                  prefixIcon: Icon(Icons.search),
//                ),
//                controller: controller,
//              ),
//              Container(
//                child: SelectableTags(
//                  activeColor: Colors.blueAccent,
//                  tags: tags,
//                  onPressed: (tag) { setState(() {}); },
//                ),
//              ),
//              ListView.builder(
//                itemCount: contents.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return _contains(index) && _isActive(index) ? InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute(contents[index]))); }, child: _card(index)) : Container();
//                },
//                physics: BouncingScrollPhysics(),
//                padding: EdgeInsets.all(0.0),
//                shrinkWrap: true,
//              ),
//            ],
//          ),
//        ),
//      ),
    );
  }
}

class Record {
  final String title;
  final Level level;
  final List<String> tags;
//  final String user;
//  final String text;
//  final Timestamp timestamp;
//  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['level'] != null),
        assert(map['tags'] != null),
        title = map['title'],
        level = getLevel(map['level']),
        tags = getTags(map['tags']);

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$level>";

  static Level getLevel(String level) {
    switch(level.toLowerCase()) {
      case "k8":
        return Level.K8;
      case "high":
        return Level.High;
      case "univ":
        return Level.Univ;
      case "sat":
        return Level.SAT;
      default:
        return Level.Unspecified;
    }
  }

  static List<String> getTags(List<dynamic> tags) {
    return tags.cast<String>();
  }
}