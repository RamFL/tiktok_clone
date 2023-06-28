import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String name;
  String profilePic;
  String email;
  String uid;

  MyUser(
      {required this.name,
      required this.profilePic,
      required this.email,
      required this.uid});

  //App(User) - Firebase (Map)
  Map<String, dynamic> toJson() {
    return {'name': name, 'profilePic': profilePic, 'email': email, 'uid': uid};
  }

  //Firebase(Map) - App(User)
  static MyUser fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return MyUser(
        name: snap['name'],
        profilePic: snap['profilePic'],
        email: snap['email'],
        uid: snap['uid']);
  }
}
