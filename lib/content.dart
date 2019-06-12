import 'package:flutter_tags/selectable_tags.dart';
import 'constants.dart';

class Content extends Comparable {
//  int id;
  String title;
  Level level;
  bool active;
  List<String> tags;

  Content(this.title, this.level, this.tags) {
    this.active = true;
  }

  void addTag(Tag tag) {
    // TODO: connect it to the db
    tags.add(tag.title);
  }

  @override
  int compareTo(other) {
    return int.parse(this.title).compareTo(int.parse(other.title));
  }
}