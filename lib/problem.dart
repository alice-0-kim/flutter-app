import 'package:flutter/material.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'comment.dart';
import 'content.dart';
import 'utility.dart';

class Problem extends StatelessWidget {
  Problem(this.content);

  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Problem"),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          children: <Widget>[
            SelectableTags(
              activeColor: Colors.white,
              textActiveColor: Colors.black,
              tags: content.tags.map((tag) => Tag(id:tag.hashCode, title: tag)).toList(),
              backgroundContainer: Colors.transparent,
              alignment: MainAxisAlignment.start,
              fontSize: 12.0,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(content.title, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            Text("Level: ${content.level.toString().split('.').last}", textAlign: TextAlign.end,),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(title: "Comments", content: content)));
                  },
                ),
              ],
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lacus odio, condimentum a consequat tincidunt, egestas quis mi. Vivamus pellentesque orci tellus, sodales posuere magna sodales cursus. Nulla euismod libero neque, ac iaculis lorem convallis ac. Integer placerat sapien ac arcu luctus, pharetra cursus odio iaculis. Proin maximus a odio in dapibus. Fusce eu porttitor ligula, nec suscipit erat. Cras blandit, erat eu varius cursus, mauris libero tempor nibh, eget aliquet lectus sapien vel massa. Sed felis lorem, semper in condimentum non, aliquam ac odio. Fusce efficitur tempor tortor in pharetra. Proin enim massa, dignissim vitae lorem ut, ultricies bibendum quam. Proin imperdiet, tellus vitae imperdiet interdum, metus nisi vestibulum sapien, in facilisis metus nisi in nisi. Phasellus molestie commodo semper. \n Ut sit amet massa vitae enim finibus malesuada vel quis libero. Donec sagittis tincidunt leo, et pharetra mauris posuere a. Nulla tempus tellus enim, et auctor lacus gravida eget. Cras mattis augue a tortor rhoncus feugiat. Vivamus faucibus congue nulla, sit amet blandit tortor condimentum eu. Cras ac est lacinia, ornare ante ut, scelerisque ipsum. Quisque eros sapien, iaculis ut ipsum sit amet, placerat convallis justo. Suspendisse rhoncus nibh mi, non imperdiet mi rutrum vel. Maecenas nec urna velit. \n Nunc facilisis mauris in condimentum aliquam. Cras ullamcorper eros non viverra ultrices. Suspendisse potenti. Pellentesque sit amet urna ac mauris porta efficitur. Nullam hendrerit lacus eu leo elementum, quis ultrices nisi placerat. Nam vitae est commodo, malesuada ante eu, faucibus turpis. Aenean egestas justo quis sem ornare, ut iaculis nulla maximus. Pellentesque tristique tellus in tempor sodales. Aliquam semper laoreet nisi placerat condimentum. Nulla sit amet elit sed nulla consequat ultrices sodales in nisl. Quisque et ultrices orci. Donec dictum dolor erat, vel malesuada leo rutrum sodales.",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}