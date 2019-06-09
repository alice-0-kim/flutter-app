import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'pages.dart';

class _CommentPageState extends State<CommentPage> {
  static const String DEFAULT_COMMENT = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  List<String> _comments = [DEFAULT_COMMENT, DEFAULT_COMMENT, DEFAULT_COMMENT, DEFAULT_COMMENT, DEFAULT_COMMENT];

  TextEditingController controller = TextEditingController();

  Widget _comment(String comment) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black45,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text("User", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Text(new DateTime.now().toString()),
            ],
          ),
          Text(comment, textAlign: TextAlign.left,),
        ],
      ),
    );
  }

  void _addComment(String comment) {
    _comments.add(comment);
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
        title: Text("Comments"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
//          ListView(
//            padding: EdgeInsets.all(10.0),
//            children: <Widget>[
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//              _comment(DEFAULT_COMMENT),
//            ],
//          ),
          ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: _comments.length,
            itemBuilder: (BuildContext context, int index) {
              return _comment(_comments[index]);
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: TextField(
                autofocus: true,
                onSubmitted: (String submitted) {
                  setState(() {
                    _addComment(submitted);
                  });
                },
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  hintText: "Add comment...",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class CommentPage extends StatefulWidget {
  CommentPage({Key key, this.title, this.item}) : super(key: key);

  final String title;
  final Item item;

  @override
  _CommentPageState createState() => _CommentPageState();
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
  ProblemRoute(this.item);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          children: <Widget>[
            SelectableTags(
              activeColor: Colors.white,
              textActiveColor: Colors.black,
              tags: item.tags,
              backgroundContainer: Colors.transparent,
              alignment: MainAxisAlignment.start,
              fontSize: 12.0,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            Text("Level: ${item.level.toString().split('.').last}", textAlign: TextAlign.end,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(title: "Comments", item: item)));
                  },
                ),
              ],
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lacus odio, condimentum a consequat tincidunt, egestas quis mi. Vivamus pellentesque orci tellus, sodales posuere magna sodales cursus. Nulla euismod libero neque, ac iaculis lorem convallis ac. Integer placerat sapien ac arcu luctus, pharetra cursus odio iaculis. Proin maximus a odio in dapibus. Fusce eu porttitor ligula, nec suscipit erat. Cras blandit, erat eu varius cursus, mauris libero tempor nibh, eget aliquet lectus sapien vel massa. Sed felis lorem, semper in condimentum non, aliquam ac odio. Fusce efficitur tempor tortor in pharetra. Proin enim massa, dignissim vitae lorem ut, ultricies bibendum quam. Proin imperdiet, tellus vitae imperdiet interdum, metus nisi vestibulum sapien, in facilisis metus nisi in nisi. Phasellus molestie commodo semper. \n Ut sit amet massa vitae enim finibus malesuada vel quis libero. Donec sagittis tincidunt leo, et pharetra mauris posuere a. Nulla tempus tellus enim, et auctor lacus gravida eget. Cras mattis augue a tortor rhoncus feugiat. Vivamus faucibus congue nulla, sit amet blandit tortor condimentum eu. Cras ac est lacinia, ornare ante ut, scelerisque ipsum. Quisque eros sapien, iaculis ut ipsum sit amet, placerat convallis justo. Suspendisse rhoncus nibh mi, non imperdiet mi rutrum vel. Maecenas nec urna velit. \n Nunc facilisis mauris in condimentum aliquam. Cras ullamcorper eros non viverra ultrices. Suspendisse potenti. Pellentesque sit amet urna ac mauris porta efficitur. Nullam hendrerit lacus eu leo elementum, quis ultrices nisi placerat. Nam vitae est commodo, malesuada ante eu, faucibus turpis. Aenean egestas justo quis sem ornare, ut iaculis nulla maximus. Pellentesque tristique tellus in tempor sodales. Aliquam semper laoreet nisi placerat condimentum. Nulla sit amet elit sed nulla consequat ultrices sodales in nisl. Quisque et ultrices orci. Donec dictum dolor erat, vel malesuada leo rutrum sodales.",
              textAlign: TextAlign.justify,
//              style: TextStyle(fontSize: 12.0),
            ),
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