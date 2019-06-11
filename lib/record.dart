import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';

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