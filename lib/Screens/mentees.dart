import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_veteran/Screens/chats.dart';
import 'package:skill_share_veteran/config/styles.dart';
import 'package:skill_share_veteran/firebase/functions.dart';

class Mentees extends StatelessWidget {
  const Mentees({super. key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mentees"),
     ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("learning")
            .where("mentormail", isEqualTo: auth.currentUser?.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            // Handle the error here, for example, show a message to the user
            return Center(
              child: Text('Error fetching data: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the data
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Check if the snapshot data is empty
          if (snapshot.data!.docs.isEmpty) {
            // Display a message when there are no mentees
            return const Center(
              child: Text('No mentees found for this mentorname.'),
            );
          }

          // If everything is fine and there are mentees, display the list of mentees
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var menteeData = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                return Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListTile(
                          onTap: () {
                            try {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>  ChatPage(
                                    trainername: menteeData["menteename"],
                                    email: menteeData["menteemail"],
                                  ),
                                ),
                              );
                            } catch (e) {
                              // Handle navigation error, if any
                              print('Navigation error: $e');
                              // You can also show a snackbar or a dialog to inform the user about the error
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error navigating to chat page'),
                                ),
                              );
                            }
                          },
                          leading: Image.asset("assets/user (2).png"),
                          title: Text( menteeData["menteename"], style: Styles.subtitle(context)),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
