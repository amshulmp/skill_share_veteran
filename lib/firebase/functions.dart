import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> createuser(Map<String, dynamic> userDetails) async {
  try {
    await auth.createUserWithEmailAndPassword(
        email: userDetails["email"], password: userDetails["password"]);
    await firestore.collection("veterans").add(userDetails);
  } catch (e) {
    String errorMessage = 'Error creating user: $e';
    if (e is FirebaseAuthException) {
      errorMessage = 'Authentication Error: ${e.message}';
    } else if (e is FirebaseException) {
      errorMessage = 'Firestore Error: ${e.message}';
    }

    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

Future<void> signin(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  } catch (e) {
    String errorMessage = 'Error signing in: $e';
    if (e is FirebaseAuthException) {
      errorMessage = 'Authentication Error: ${e.message}';
    }

    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

Future<void> updateprofile(Map<String, dynamic> userDetails) async {
  try {
    QuerySnapshot snapshot = await firestore
        .collection("veterans")
        .where("email", isEqualTo: auth.currentUser!.email)
        .get();
    final docid = snapshot.docs.first.id;
    await firestore.collection("veterans").doc(docid).update(userDetails);
  } catch (e) {
    String errorMessage = 'Error updating profile: $e';
    if (e is FirebaseException) {
      errorMessage = 'Firestore Error: ${e.message}';
    }

    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

Future<void> sendmessage(Map<String, dynamic> message) async {
  try {
    await firestore.collection("veterans").add(message);
  } catch (e) {
    String errorMessage = 'Error sending message: $e';
    if (e is FirebaseException) {
      errorMessage = 'Firestore Error: ${e.message}';
    }

    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

Future<void> updateprogress(Map<String, dynamic> progress) async {
  try {
    await firestore.collection("veterans").add(progress);
  } catch (e) {
    String errorMessage = 'Error updating progress: $e';
    if (e is FirebaseException) {
      errorMessage = 'Firestore Error: ${e.message}';
    }

    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
Future<void> signout() async {
  try {
    await auth.signOut();
  }
   catch (e) {
    String errorMessage = 'Error signing out: $e';
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}




Future<String?> uploadFileToFirebase(File file) async {
  try {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(file.path.split("/").last); 
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  } on FirebaseException catch (e) {
    // ignore: avoid_print
    print('Error uploading file to Firebase Storage: $e');
    return null;
  }
}

Future<void> addpayment(Map<String, dynamic> paymentDetails) async {
  await firestore.collection("payments").add(paymentDetails);
}


