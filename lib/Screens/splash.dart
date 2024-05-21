// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_veteran/Screens/Homescreen.dart';
import 'package:skill_share_veteran/Screens/login.dart';
import 'package:skill_share_veteran/config/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() async{
   
     
         
     Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (BuildContext context) => 
      (FirebaseAuth.instance.currentUser == null) ?
  
      const LoginScreen() :const HomeScreen(),
  ),
);

    } );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   
      body:Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: AvatarGlow(
                startDelay: const Duration(seconds: 1),
                glowColor: Colors.blue,
                glowShape: BoxShape.circle,
                animate: true,
                curve: Curves.easeIn,
                child: Material(
                    elevation: 4.0,
                    shape: const CircleBorder(),
                    color: Colors.blue,
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: AvatarGlow(
                startDelay: const Duration(seconds: 1),
                glowColor: Colors.blue,
                glowShape: BoxShape.circle,
                animate: true,
                curve: Curves.easeIn,
                child: Material(
                    elevation: 4.0,
                    shape: const CircleBorder(),
                    color: Colors.blue,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset("assets/graduation.png"),
                    )),
              ),
                    )),
              ),
           ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("Skill Sphere",
                           style: Styles.title(context),),
             )
          ],
        ),
      )
    );
  }
}