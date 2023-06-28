import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    // Get thumbnails
    List<String> thumbnails = [];
    var myVideos = await FirebaseFirestore.instance
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    // Get user follower, following and likes count
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_uid.value)
        .get();
    final userData = userDoc.data() as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePic'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    // Get followers and following details
    var followerDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_uid.value)
        .collection('following')
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    FirebaseFirestore.instance
        .collection('Users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    // Store the values in usermap
    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };
    update();
  }

  followUser() async {
    var doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});

      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();

      _user.value.update(
        'followers',
            (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
