// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_veteran/Screens/preview.dart';
import 'package:skill_share_veteran/Screens/viewfile.dart';
import 'package:skill_share_veteran/config/styles.dart';
import 'package:skill_share_veteran/firebase/functions.dart';

class Addvideos extends StatefulWidget {
  const Addvideos({super.key});

  @override
  State<Addvideos> createState() => _AddvideosState();
}

class _AddvideosState extends State<Addvideos> {
  File?videoFile;
  Future<void> pickVideoAndSave() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );
      if (result != null) {
        setState(() {
          videoFile = File(result.files.single.path!);
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // Handle any exceptions
      print('Error picking video: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: const Text("Home"),),
       body: Padding(
         padding: const EdgeInsets.all(13.0),
         child: Column(
          children: [
             SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                  Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListTile(
                    onTap: ()async{
                      await pickVideoAndSave();
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                 Preview(video: videoFile,),
                          ),
                        );
                      },
                      leading: Image.asset("assets/video-posting.png"),
                      title: Text("Add video",style: Styles.subtitle(context),
                      ),
                        
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Videos",style: Styles.title(context)),
                ),
                StreamBuilder(
  stream: firestore
      .collection("videos")
      .where("traineremail", isEqualTo: auth.currentUser?.email)
      .snapshots(),
  builder: (
    BuildContext context,
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
  ) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }

    if (snapshot.data?.docs.isEmpty ?? true) {
      return const Center(
        child: Text(
          'No videos found.',
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: snapshot.data?.docs.length ?? 0,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          var videoData = snapshot.data!.docs[index].data();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  onTap: () {
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                               ViewVideo(video: Uri.parse(videoData["url"]),),
                        ),
                      );
                  },
                  leading: Image.asset("assets/video-marketing.png"),
                  title: Text(
                    videoData["title"] ?? "Untitled",
                    style: Styles.subtitle(context),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  },
)

          ],
         ),
       ),
    );
  }
}