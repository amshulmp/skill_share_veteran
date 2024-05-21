import 'package:flutter/material.dart';
import 'package:skill_share_veteran/Screens/addvideos.dart';
import 'package:skill_share_veteran/Screens/login.dart';
import 'package:skill_share_veteran/Screens/mentees.dart';
import 'package:skill_share_veteran/Screens/profile.dart';
import 'package:skill_share_veteran/config/styles.dart';
import 'package:skill_share_veteran/firebase/functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),
       actions: [
        IconButton(onPressed: ()async{
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
          await signout();
        }, icon:const Icon( Icons.logout,color: Colors.black,))
      ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  17.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                       onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Mentees(),
                        ),
                      );
                    },
                    leading: Image.asset("assets/graduation.png"),
                    title: Text("Mentees",style: Styles.subtitle(context),),
                
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                  onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Profile(),
                        ),
                      );
                    },
                    leading: Image.asset("assets/user (2).png"),
                    title: Text("Profile",style: Styles.subtitle(context),
                    ),
                      
                  ),
                ),
              ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                  onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Addvideos(),
                        ),
                      );
                    },
                    leading: Image.asset("assets/video-marketing.png"),
                    title: Text("My videos",style: Styles.subtitle(context),
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