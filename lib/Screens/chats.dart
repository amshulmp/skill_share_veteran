
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_veteran/Screens/callpage.dart';
import 'package:skill_share_veteran/firebase/functions.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ChatPage extends StatefulWidget {
  final dynamic trainername;
  final dynamic email;

  const ChatPage({
    super.key,
    required this.trainername,
    required this.email,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List ids = [widget.email, FirebaseAuth.instance.currentUser!.email];
    ids.sort();
    String chatroomid = ids.join("_");
    print(chatroomid);
    return Scaffold(
      appBar: AppBar(
        title: Text("mentee ${widget.trainername}"),
        actions: [
          IconButton(onPressed: (){
             Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>  Videocall(callID: chatroomid, userID:FirebaseAuth.instance.currentUser!.email , userName: widget.trainername, config:ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall() ,),
                      ),);
          }, icon: const Icon(Icons.call,color: Colors.black)),
            IconButton(onPressed: (){
               Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>  Videocall(callID: chatroomid, userID:FirebaseAuth.instance.currentUser!.email , userName: widget.trainername, config:ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall() ,),
                      ),);
            }, icon: const Icon(Icons.videocam,color: Colors.black))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(chatroomid)
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                // final data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.active) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      // final userData = data!.docs[index];
                      // final userId = userData.id;
                      Map<String, dynamic> usermap = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      return Align(
                        alignment: (usermap["sender"] ==
                                FirebaseAuth.instance.currentUser!.email)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: (usermap["sender"] ==
                                        FirebaseAuth
                                            .instance.currentUser!.email)
                                    ? Colors.green
                                    : Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(usermap["message"]),
                              )),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Textbox1(
              text: "enter message",
              controller: message,
              onpress: ()async{
               await sendmessage(auth.currentUser?.email, widget.email, message.text.trim());
               message.clear();
              },
            ),
          )
        ],
      ),
    );
  }
}

dynamic sendmessage(
    dynamic senderemail, dynamic recieveremail, String message) async {
  List ids = [senderemail, recieveremail];
  ids.sort();
  String chatroomid = ids.join("_");
  Timestamp timestamp = Timestamp.now();
  await firestore.collection(chatroomid).add({
    "sender": senderemail,
    "reciever": recieveremail,
    "timestamp": timestamp,
    "message": message
  });
}

class Textbox1 extends StatelessWidget {
  final dynamic text;
  final dynamic controller;
  final dynamic onpress;

  const Textbox1({
    super.key,
    required this.text,
    required this.controller,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      height: 60,
      child: Center(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            filled: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.white)),
            fillColor: Theme.of(context).colorScheme.onSurfaceVariant,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            suffixIcon: IconButton(onPressed: onpress, icon:  const Icon(Icons.send,color: Colors.black))
          ),
        ),
      ),
    );
  }
}
