import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skill_share_veteran/config/styles.dart';
import 'package:skill_share_veteran/firebase/functions.dart';

class Profile extends StatelessWidget {
  const Profile({super. key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("veterans")
            .where("email", isEqualTo: auth.currentUser?.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No data available for this user.'),
            );
          }

          // Assuming there's only one document for the current user
          var userData = snapshot.data!.docs.first.data() as Map<String,dynamic>;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          child: const CircleAvatar(
                            backgroundImage: AssetImage("assets/user (2).png"),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Username",
                        style: Styles.subtitlegrey(context),
                      ),
                    
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      userData["username"] ?? "No username",
                      style: Styles.labelText(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "email",
                        style: Styles.subtitlegrey(context),
                      ),
                    
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      userData["email"] ?? "No email",
                      style: Styles.labelText(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "skill",
                        style: Styles.subtitlegrey(context),
                      ),
                    
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      userData["skill"] ?? "skill",
                      style: Styles.labelText(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "description",
                        style: Styles.subtitlegrey(context),
                      ),
                    
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      userData["description"] ?? "No description",
                      style: Styles.labelText(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Type",
                        style: Styles.subtitlegrey(context),
                      ),
                    
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      userData["type"] ?? "No type",
                      style: Styles.labelText(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
