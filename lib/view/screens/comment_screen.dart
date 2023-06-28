import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tiktok_clone/controller/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  String id;
  CommentScreen({Key? key, required this.id}) : super(key: key);

  final TextEditingController _commentController = TextEditingController();

  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        var comment = commentController.comments[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                "${comment.username}  ",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                timeago.format(comment.datePublished.toDate()),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  comment.comment,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${comment.likes.length.toString()} likes",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              commentController.likeComments(comment.id);
                            },
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: comment.likes
                                      .contains(authController.user.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      }),
                ),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Add a Comment...',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController
                        .postComment(_commentController.text.trim());
                    _commentController.clear();
                  },
                  child: const Text(
                    'post',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
