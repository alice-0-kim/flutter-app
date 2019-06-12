import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'content.dart';
import 'main.dart';
import 'utility.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key, this.title, this.content}) : super(key: key);

  final String title;
  final Content content;

  @override
  _CommentPageState createState() {
    return _CommentPageState();
  }
}

class _CommentPageState extends State<CommentPage> {
  void _addComment(GoogleSignInAccount user, String text, Content content) {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(Firestore.instance.collection("comment").document(), {
        "userId": user.id,
        "user": user.displayName,
        "content": content.title,
        "text": text,
        "timestamp": new Timestamp.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(widget.title),
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
              onSubmitted: (String submitted) {
                setState(() {
                  _addComment(currentUser, submitted, widget.content);
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
    final comment = Comment.fromSnapshot(data);

    return comment.content.toLowerCase() == widget.content.title.toLowerCase() ? Padding(
      key: ValueKey(comment.user),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
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
                  child: Text(comment.user, style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Text(new DateFormat('yyyy-MM-dd HH:mm:ss').format(comment.timestamp.toDate())),
              ],
            ),
            Text(comment.text, textAlign: TextAlign.left,),
          ],
        ),
      ),
    ) : Container();
  }
}

class Comment {
//  final int userId;
  final String user, content, text;
  final Timestamp timestamp;
  final DocumentReference reference;

  Comment.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['user'] != null),
//        assert(map['userId'] != null),
        assert(map['content'] != null),
        assert(map['text'] != null),
        assert(map['timestamp'] != null),
        user = map['user'],
//        userId = map['userId'],
        content = map['content'],
        text = map['text'],
        timestamp = map['timestamp'];

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Comment<$user>";
}