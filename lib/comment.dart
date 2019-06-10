import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'pages.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key, this.title, this.item}) : super(key: key);

  final String title;
  final Item item;

  @override
  _CommentPageState createState() {
    return _CommentPageState();
  }
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('comment').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildStack(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildStack(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Stack(
      children: <Widget>[
        _buildList(context, snapshot),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: TextField(
              autofocus: true,
              onSubmitted: (String submitted) {
                setState(() {
                  // TODO: update behaviour
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20.0),
                hintText: "Add comment...",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.all(5.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.user),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black45,
            ),
          ),
        ),
//        child: ListTile(
//          title: Text(record.user),
//          trailing: Text(0.toString()),
//          onTap: () => print(record),
//        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(record.user, style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Text(new DateFormat('yyyy-MM-dd HH:mm:ss').format(record.timestamp.toDate())),
              ],
            ),
            Text(record.text, textAlign: TextAlign.left,),
          ],
        ),
      ),
    );
  }
}

class Record {
  final String user;
  final String text;
  final Timestamp timestamp;
//  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['user'] != null),
        assert(map['text'] != null),
        assert(map['timestamp'] != null),
        user = map['user'],
        text = map['text'],
        timestamp = map['timestamp'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$user>";
}