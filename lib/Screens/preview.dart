import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skill_share_veteran/firebase/functions.dart';
import 'package:video_player/video_player.dart';

class Preview extends StatefulWidget {
  final dynamic video;

  const Preview({super. key, required this.video});

  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  late VideoPlayerController controller;
  bool isPlaying = false;
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPlaying = !isPlaying;
                              if (isPlaying) {
                                controller.play();
                              } else {
                                controller.pause();
                              }
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(controller),
                              if (!isPlaying)
                                const Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ),
                            ],
                          ),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Enter video title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final url = await uploadFileToFirebase(widget.video);
          await firestore.collection("videos").add({
            "traineremail": auth.currentUser?.email,
            "url": url,
            "title": titleController.text, // Use titleController.text to get the text value
          });
          Navigator.pop(context);
        },
        child: const Icon(Icons.send, color: Colors.black),
      ),
    );
  }
}
