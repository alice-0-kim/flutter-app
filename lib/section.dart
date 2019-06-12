import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';
import 'record.dart';
import 'content.dart';
import 'problem.dart';
import 'utility.dart';

class Section extends StatelessWidget {
  Section({this.title, this.tag, this.level, this.icon});

  final String title, tag;
  final Level level;
  final IconData icon;

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
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Hero(
                tag: tag,
                child: Icon(icon, size: 50.0,),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(title),
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
//            ListView.builder(
//              itemCount: contents.length,
//              itemBuilder: (BuildContext context, int index) {
//                return contents[index].level == level ? InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute(contents[index]))); }, child: _buildCard(index)) : Container();
//              },
//              physics: BouncingScrollPhysics(),
//              padding: EdgeInsets.all(0.0),
//              shrinkWrap: true,
//            ),
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

    return record.level == level ? InkWell(
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

  Card _buildCard(Record record) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(record.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title),
      body: _buildBody(context),
    );
  }
}