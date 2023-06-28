import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/model/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = '';

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  // To get the comment
  getComment() async {
    _comments.bindStream(
      FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> retValue = [];

          for (var element in query.docs) {
            retValue.add(Comment.fromJson(element));
          }
          return retValue;
        },
      ),
    );
  }

  // To post the comment
  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(authController.user.uid)
            .get();
        var allDocs = await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        // To generate ID of comment
        int len = allDocs.docs.length;

        Comment comment = Comment(
          uid: (userDoc.data()! as dynamic)['uid'],
          id: 'comment $len',
          username: (userDoc.data()! as dynamic)['name'],
          comment: commentText.trim(),
          profilePhoto: (userDoc.data()! as dynamic)['profilePic'],
          likes: [],
          datePublished: DateTime.now(),
        );
        await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('comment $len')
            .set(comment.toJson());

        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postId)
            .get();

        await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postId)
            .update({
          'commentsCount': (doc.data() as dynamic)['commentsCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar("Error to comment", e.toString());
    }
  }

  // To likes the comment
  likeComments(String id) async {
    String uid = authController.user.uid;

    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((docs.data() as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        "likes": FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        "likes": FieldValue.arrayUnion([uid]),
      });
    }
  }
}
