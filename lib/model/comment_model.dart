import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String uid;
  String id;
  String username;
  String comment;
  String profilePhoto;
  List likes;
  final datePublished;

  Comment({
    required this.uid,
    required this.id,
    required this.username,
    required this.comment,
    required this.profilePhoto,
    required this.likes,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'id': id,
        'username': username,
        'comment': comment,
        'profilePhoto': profilePhoto,
        'likes': likes,
        'datePublished': datePublished,
      };

  static Comment fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comment(
      uid: snapshot['uid'],
      id: snapshot['id'],
      username: snapshot['username'],
      comment: snapshot['comment'],
      profilePhoto: snapshot['profilePhoto'],
      likes: snapshot['likes'],
      datePublished: snapshot['datePublished'],
    );
  }
}
