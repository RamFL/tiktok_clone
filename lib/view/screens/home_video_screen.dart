import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/video_controller.dart';
import 'package:tiktok_clone/view/screens/comment_screen.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';
import 'package:tiktok_clone/view/widgets/circle_animation.dart';
import 'package:tiktok_clone/view/widgets/video_player_item.dart';

class HomeVideoScreen extends StatelessWidget {
  HomeVideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> share(String vidId) async {
    await FlutterShare.share(
      title: 'Download TikTok clone App',
      text: 'Watch the interesting shorts in TikTok clone',
    );
    videoController.shareVideos(vidId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(
        () => PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                InkWell(
                  onDoubleTap: () {
                    videoController.likeVideos(data.id);
                  },
                  child: VideoPlayerItem(videoUrl: data.videoUrl),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data.username,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data.caption,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        data.songname,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(top: size.height / 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ProfileScreen(
                                        uid: data.uid,
                                      ),
                                    );
                                  },
                                  child: buildProfile(data.profilePhoto),
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        videoController.likeVideos(data.id);
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        size: 40,
                                        color: data.likes.contains(
                                                authController.user.uid)
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      data.likes.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => CommentScreen(
                                            id: data.id,
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.comment,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      data.commentsCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        share(data.id);
                                      },

                                      //{
                                      //   showModalBottomSheet(
                                      //       context: context,
                                      //       builder: (context) {
                                      //         return Container(
                                      //           decoration: BoxDecoration(
                                      //             color:
                                      //                 Colors.blueGrey.shade100,
                                      //             borderRadius:
                                      //                 const BorderRadius.only(
                                      //                     topLeft:
                                      //                         Radius.circular(
                                      //                             20),
                                      //                     topRight:
                                      //                         Radius.circular(
                                      //                             20)),
                                      //           ),
                                      //           child: Column(
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               const SizedBox(
                                      //                 height: 50,
                                      //               ),
                                      //               Row(
                                      //                 children: const [
                                      //                   Padding(
                                      //                     padding:
                                      //                         EdgeInsets.all(
                                      //                             8.0),
                                      //                     child: Icon(
                                      //                       Icons.people,
                                      //                       size: 35,
                                      //                       color: Colors
                                      //                           .lightBlue,
                                      //                     ),
                                      //                   ),
                                      //                   SizedBox(
                                      //                     width: 15,
                                      //                   ),
                                      //                   Text(
                                      //                     'Share with your friends',
                                      //                     style: TextStyle(
                                      //                         color:
                                      //                             Colors.black,
                                      //                         fontSize: 20,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .w500),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //               const Divider(
                                      //                 thickness: 2,
                                      //               ),
                                      //               Row(
                                      //                 children: const [
                                      //                   Padding(
                                      //                     padding:
                                      //                         EdgeInsets.all(
                                      //                             8.0),
                                      //                     child: Icon(
                                      //                       Icons.people,
                                      //                       size: 35,
                                      //                       color: Colors
                                      //                           .lightBlue,
                                      //                     ),
                                      //                   ),
                                      //                   SizedBox(
                                      //                     width: 15,
                                      //                   ),
                                      //                   Text(
                                      //                     'Share with your friends',
                                      //                     style: TextStyle(
                                      //                         color:
                                      //                             Colors.black,
                                      //                         fontSize: 20,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .w500),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //               const Divider(
                                      //                 thickness: 2,
                                      //               ),
                                      //               Row(
                                      //                 children: const [
                                      //                   Padding(
                                      //                     padding:
                                      //                         EdgeInsets.all(
                                      //                             8.0),
                                      //                     child: Icon(
                                      //                       Icons.people,
                                      //                       size: 35,
                                      //                       color: Colors
                                      //                           .lightBlue,
                                      //                     ),
                                      //                   ),
                                      //                   SizedBox(
                                      //                     width: 15,
                                      //                   ),
                                      //                   Text(
                                      //                     'Share with your friends',
                                      //                     style: TextStyle(
                                      //                         color:
                                      //                             Colors.black,
                                      //                         fontSize: 20,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .w500),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //               const Divider(
                                      //                 thickness: 2,
                                      //               ),
                                      //               Row(
                                      //                 children: const [
                                      //                   Padding(
                                      //                     padding:
                                      //                         EdgeInsets.all(
                                      //                             8.0),
                                      //                     child: Icon(
                                      //                       Icons.people,
                                      //                       size: 35,
                                      //                       color: Colors
                                      //                           .lightBlue,
                                      //                     ),
                                      //                   ),
                                      //                   SizedBox(
                                      //                     width: 15,
                                      //                   ),
                                      //                   Text(
                                      //                     'Share with your friends',
                                      //                     style: TextStyle(
                                      //                         color:
                                      //                             Colors.black,
                                      //                         fontSize: 20,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .w500),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //               const Divider(
                                      //                 thickness: 15,
                                      //               ),
                                      //               SingleChildScrollView(
                                      //                 scrollDirection:
                                      //                     Axis.horizontal,
                                      //                 child: Row(
                                      //                   children: [
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.bluetooth,
                                      //                         size: 35,
                                      //                         color:
                                      //                             Colors.blue,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.whatsapp,
                                      //                         size: 35,
                                      //                         color:
                                      //                             Colors.green,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.facebook,
                                      //                         size: 35,
                                      //                         color: Colors
                                      //                             .deepPurple,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.telegram,
                                      //                         size: 35,
                                      //                         color: Colors
                                      //                             .blueAccent,
                                      //                       ),
                                      //                     ),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.bluetooth,
                                      //                         size: 35,
                                      //                         color:
                                      //                             Colors.blue,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.whatsapp,
                                      //                         size: 35,
                                      //                         color:
                                      //                             Colors.green,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.facebook,
                                      //                         size: 35,
                                      //                         color: Colors
                                      //                             .deepPurple,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.telegram,
                                      //                         size: 35,
                                      //                         color: Colors
                                      //                             .blueAccent,
                                      //                       ),
                                      //                     ),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.bluetooth,
                                      //                         size: 35,
                                      //                         color:
                                      //                             Colors.blue,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.whatsapp,
                                      //                         size: 35,
                                      //                         color:
                                      //                             Colors.green,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.facebook,
                                      //                         size: 35,
                                      //                         color: Colors
                                      //                             .deepPurple,
                                      //                       ),
                                      //                     ),
                                      //                     const SizedBox(
                                      //                         width: 10),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                               .all(8.0),
                                      //                       child: Icon(
                                      //                         Icons.telegram,
                                      //                         size: 35,
                                      //                         color: Colors
                                      //                             .blueAccent,
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         );
                                      //       });
                                      // },
                                      child: const Icon(
                                        Icons.reply,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      data.shareCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                CircleAnimation(
                                  child: buildMusicAlbum(data.profilePhoto),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
