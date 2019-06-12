import 'package:flutter/material.dart';
import 'utility.dart';
import 'constants.dart';
import 'section.dart';

//class Section extends StatelessWidget {
//  Section({this.title, this.tag, this.level, this.icon});
//
//  final String title, tag;
//  final Level level;
//  final IconData icon;
//
//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('content').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return LinearProgressIndicator();
//        return _buildContainer(context, snapshot.data.documents);
//      },
//    );
//  }
//
//  Widget _buildContainer(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return Container(
//      padding: EdgeInsets.all(30.0),
//      child: Center(
//        child: Column(
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(20.0),
//              child: Hero(
//                tag: tag,
//                child: Icon(icon, size: 50.0,),
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(bottom: 20.0),
//              child: Text(title),
//            ),
//            Text(
//              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
//              textAlign: TextAlign.center,
//              style: TextStyle(fontSize: 12.0),
//            ),
////            ListView.builder(
////              itemCount: contents.length,
////              itemBuilder: (BuildContext context, int index) {
////                return contents[index].level == level ? InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute(contents[index]))); }, child: _buildCard(index)) : Container();
////              },
////              physics: BouncingScrollPhysics(),
////              padding: EdgeInsets.all(0.0),
////              shrinkWrap: true,
////            ),
//            _buildList(context, snapshot),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      padding: const EdgeInsets.all(5.0),
//      shrinkWrap: true,
//      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//    );
//  }
//
//  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//    final record = Record.fromSnapshot(data);
//
//    return record.level == level ? InkWell(
//      onTap: () {
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) => Problem(Content(record.title, record.level, record.tags)),
//          ),
//        );
//      },
//      child: _buildCard(record),
//    ) : Container();
//  }
//
//  Card _buildCard(Record record) {
//    return Card(
//      child: Padding(
//        padding: const EdgeInsets.all(16.0),
//        child: Text(record.title),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text(title),
//        ),
//        body: _buildBody(context),
//    );
//  }
//}

class ByLevels extends StatefulWidget {
  ByLevels({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ByLevelsState createState() => _ByLevelsState();
}

class _ByLevelsState extends State<ByLevels> {
  Widget _buildRaisedButton(String title, String tag, Level level, String label, IconData icon) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Section(title: title, tag: tag, level: level, icon: icon))
        );
      },
      child: Column(
        children: <Widget>[
          Hero(
            tag: tag,
            child: Icon(icon),
          ),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(widget.title),
      body: Container(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildRaisedButton("K - 8th Grade", "K8", Level.K8, "K-8", Icons.directions_walk),
                  Padding(padding: EdgeInsets.all(2.5)),
                  _buildRaisedButton("9 - 12th Grade", "912", Level.High, "High", Icons.directions_bike),
                ],
              ),
              Padding(padding: EdgeInsets.all(2.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildRaisedButton("SAT", "SAT", Level.SAT, "SAT", Icons.airport_shuttle),
                  Padding(padding: EdgeInsets.all(2.5)),
                  _buildRaisedButton("University", "Univ", Level.Univ, "Univ", Icons.airplanemode_active),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}