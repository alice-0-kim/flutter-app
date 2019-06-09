import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'pages.dart';

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
  ProblemRoute(this.item);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
//            Hero(
//              tag: "Tag 3",
//              child: Icon(Icons.mail, size: 50.0,),
//            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0, bottom: 20.0),
              child: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Text("Level: ${item.level.toString().split('.').last}"),
            Padding(
              padding: EdgeInsets.all(20.0),
//              child: ListView.builder(
//                itemCount: item.tags.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return Text(item.tags[index].title);
//                },
//                physics: BouncingScrollPhysics(),
//                padding: EdgeInsets.all(0.0),
//                shrinkWrap: true,
//              ),
              child: SelectableTags(
                activeColor: Colors.white,
                textActiveColor: Colors.black,
                tags: item.tags,
                backgroundContainer: Colors.transparent,
                alignment: MainAxisAlignment.start,
//                onPressed: (tag) { setState(() {}); },
              ),
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
//            Padding(
//              padding: EdgeInsets.all(20.0),
//              child:
//              FlatButton(
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//                child: Text('Go back'),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}

class LevelRoute extends StatelessWidget {

  LevelRoute({this.title, this.tag, this.level});

  final String title, tag;
  final Level level;

//  InkWell _inkWell(Card card) {
//    return InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute())); }, child: card);
//  }

//  List<Item> items = [];
//
//  void _initItems() {
//    Item item1 = Item("K-8 1", Level.K8);
//    item1.addTag("algebra");
//    Item item2 = Item("K-8 2", Level.K8);
//    Item item3 = Item("K-8 3", Level.K8);
//    Item item4 = Item("High 1", Level.High);
//    item4.addTag("differentiation");
//    Item item5 = Item("High 2", Level.High);
//    item5.addTag("integration");
//    Item item6 = Item("High 3", Level.High);
//    Item item7 = Item("Univ 1", Level.Univ);
//    item7.addTag("calculus Ⅱ");
//    Item item8 = Item("Univ 2", Level.Univ);
//    Item item9 = Item("Univ 3", Level.Univ);
//    Item item10 = Item("SAT 1", Level.SAT);
//    item10.addTag("important");
//    Item item11 = Item("SAT 2", Level.SAT);
//    Item item12 = Item("SAT 3", Level.SAT);
//    items.addAll([item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12]);
//  }

  Card _card(int index) {
    return Card(child: Padding(padding: const EdgeInsets.all(16.0), child: Text(items[index].title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Hero(
                  tag: tag,
                  child: Icon(Icons.airport_shuttle, size: 50.0,),
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
              ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return items[index].level == level ? InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemRoute(items[index]))); }, child: _card(index)) : Container();
                },
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0.0),
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      )
    );
  }
}