import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'problem.dart';
import 'content.dart';
import 'utility.dart';
import 'constants.dart';

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  String filter;
  List<Tag> tags = [];

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('content').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
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

    return _isActive(record) ? InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Problem(Content(record.title, record.level, record.tags)),
          ),
        );
      },
      child: _buildCard(record),
    ) : Container();
  }

  bool _isActive(Record record) {
    return tags.any((tag) => tag.active && record.tags.contains(tag.title));
  }

  Card _buildCard(Record record) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(record.title),
      ),
    );
  }

  void _initTags() {
    tags.add(Tag(id: 0, title: "algebra", active: false));
    tags.add(Tag(id: 1, title: "advanced",  active: false));
    tags.add(Tag(id: 2, title: "elementary",  active: false));
    tags.add(Tag(id: 3, title: "calculus",  active: false));
    tags.add(Tag(id: 4, title: "important",  active: false));
  }

  @override
  initState() {
    super.initState();
    _initTags();
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
      appBar: buildAppBar(widget.title),
      body: _buildBody(context),
    );
  }
}

class Record {
  final String title;
  final Level level;
  final List<String> tags;
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