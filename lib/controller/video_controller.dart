import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/model/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(FirebaseFirestore.instance
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retValues = [];

      for (var element in query.docs) {
        retValues.add(
          Video.fromJson(element),
        );
      }
      return retValues;
    }));
  }

  likeVideos(String id) async {
    String uid = authController.user.uid;
    //  await FirebaseFirestore.instance
    //     .collection('videos')
    //     .doc(id)
    //     .get()
    //     .then((value) async {
    //    print("Document Id: $id");
    //   if (value.exists) {
    //     Video video = Video.fromJson(jsonDecode(jsonEncode(value.data())));
    //
    //
    //
    //     if (video.likes.contains(uid)) {
    //   await FirebaseFirestore.instance.collection('videos').doc(id).update({
    //     "likes": FieldValue.arrayRemove([uid]),
    //   });
    // } else {
    //   await FirebaseFirestore.instance.collection('videos').doc(id).update({
    //     "likes": FieldValue.arrayUnion([uid]),
    //   });
    // }
    //   print(video.likes.length.toString());
    // }
    //
    // });
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('videos').doc(id).get();

    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection('videos').doc(id).update({
        "likes": FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance.collection('videos').doc(id).update({
        "likes": FieldValue.arrayUnion([uid]),
      });
    }
  }

  shareVideos(String vidId) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('videos').doc(vidId).get();

    int newshareCount = ((doc.data() as dynamic)['shareCount']) + 1;

    await FirebaseFirestore.instance.collection('videos').doc(vidId).update({
      'shareCount': newshareCount,
    });
  }
}
