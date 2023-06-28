import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/upload_video_controller.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                        controller: songController,
                        myIcon: Icons.music_note,
                        myLabelText: 'Song name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                        controller: captionController,
                        myIcon: Icons.closed_caption,
                        myLabelText: 'Caption'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        uploadVideoController.uploadVideo(songController.text,
                            captionController.text, widget.videoPath);
                        // After uploaded video will off and sound off
                      },
                      child: const Text(
                        'Share!',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
