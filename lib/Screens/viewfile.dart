import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class ViewVideo extends StatefulWidget {
  final dynamic video;

  const ViewVideo({super.key, required this.video});

  @override
  // ignore: library_private_types_in_public_api
  _ViewVideoState createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late VideoPlayerController controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(widget.video)
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
      body: Center(
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
    );
  }
}
