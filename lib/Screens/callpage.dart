import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';


class Videocall extends StatelessWidget {
  final dynamic callID;
  final dynamic userID;
  final dynamic userName;
   final dynamic config;
  const Videocall(
      {super.key,
      required this.callID,
      required this.userID,
      required this.userName,required this.config});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
      body: ZegoUIKitPrebuiltCall(
          appID: 424926948,
          appSign:
              "e75601641abe4cf68ca0f5430a0370f999b121d96d72ae3d295df45cbae5aa6b",
          callID: callID,
          userID: userID,
          userName: userName,
          config:config),
    ));
  }
}
