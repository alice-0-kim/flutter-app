import 'package:flutter_tags/selectable_tags.dart';

int _id = 0;

enum Level {
  K8, High, Univ, SAT, Unspecified
}

class Content extends Comparable {
  int id;
  String title;
  Level level;
  bool active;
  List<String> tags;

  Content(this.title, this.level, this.tags) {
    this.id = _id++;
    this.active = true;
  }

  void addTag(Tag tag) {
    tags.add(tag.title);
  }

  bool containsTag(Tag tag) {
    return tags.contains(tag.title);
  }

  bool isActive(List<Tag> activeTags) {
    return activeTags.any((tag) => tags.contains(tag.title));
  }

  @override
  int compareTo(other) {
    return int.parse(this.title).compareTo(int.parse(other.title));
  }
}