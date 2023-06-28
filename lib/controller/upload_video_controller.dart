import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/video_model.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  // To compress the video quality
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  // To upload the video in firebase Storage and get download url
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //Get File thumbnail from VideoPath
  _getThumbnail(String videoPath) async {
    final thumbnailFile = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnailFile;
  }

  // To upload the Thumbnail image in firebase Storage and get download url
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('thumbnails').child(id);

    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      //videoId - get ID
      var allDocs = await FirebaseFirestore.instance.collection('videos').get();
      int len = allDocs.docs.length;

      String videoUrl = await _uploadVideoToStorage('video $len', videoPath);
      String thumbnail = await _uploadImageToStorage('video $len', videoPath);

      // if (userDoc != null) {}
      Video video = Video(
        username: (userDoc.data() as Map<String, dynamic>)['name'],
        uid: uid,
        id: 'video $len',
        likes: [],
        commentsCount: 0,
        shareCount: 0,
        songname: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto: (userDoc.data() as Map<String, dynamic>)['profilePic'],
      );
      await FirebaseFirestore.instance
          .collection('videos')
          .doc('video $len')
          .set(video.toJson());

      Get.back();
      Get.snackbar('Video Uploaded', 'video uploaded successfully');
    } catch (e) {
      print(e);
      Get.snackbar('Error uploading video', e.toString());
    }
  }
}
