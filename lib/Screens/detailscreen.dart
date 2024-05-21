import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_share_veteran/Screens/homescreen.dart';
import 'package:skill_share_veteran/Screens/login.dart';
import 'package:skill_share_veteran/Screens/verify.dart';
import 'package:skill_share_veteran/config/styles.dart';
import 'package:skill_share_veteran/firebase/functions.dart';
import 'package:skill_share_veteran/widgets/button.dart';
import 'package:skill_share_veteran/widgets/textbox.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  
 Future<void> pickCertificateFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        certificate = File(pickedFile.path);
      });
    } else {
      // User canceled the image picking
    }
  }

void register() {
  if (skillcontroller.text.trim().isEmpty ||
      descriptioncontroller.text.trim().isEmpty ||
      type == null ||
      certificate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all fields and choose a certificate.'),
        duration: Duration(seconds: 3),
      ),
    );
    return;
  }

}

  TextEditingController skillcontroller=TextEditingController();
  TextEditingController descriptioncontroller=TextEditingController();
  File ? certificate;
  String ? type;
   List<String> skillCategories = [
    'Music',
    'Education',
    'Dance',
    'Art',
    'Sports',
    'Cooking',
    'Programming',
    'Writing',
    'Design',
    'Fitness'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Enter Details to continue",style: Styles.title(context),),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                 Textbox(hideText: false, tcontroller: skillcontroller, type: TextInputType.text, hinttext: "Skill Name",icon:  Icon(Icons.app_registration,color:Theme.of(context). colorScheme.onPrimary,),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Textbox2(hideText: false, tcontroller: descriptioncontroller, type: TextInputType.multiline, hinttext: "Describe yourself",icon:  Icon(Icons.description,color:Theme.of(context). colorScheme.onPrimary,),),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                   DropdownButtonFormField<String>(
                  value: type,
                  items: skillCategories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      type = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                    border: OutlineInputBorder(),
                  ),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                CustomLoginButton(text: "choose certificate file", onPress: pickCertificateFile),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  certificate != null
                    ? Image.file(
                        certificate!,
                        fit: BoxFit.scaleDown,
                      )
                    : const SizedBox.shrink(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                CustomLoginButton(text: "register", onPress: ()async{
                  final imageurl= await uploadFileToFirebase(certificate!);
                  await updateprofile({
                    "skill":skillcontroller.text.trim(),
                    "description":descriptioncontroller.text.trim(),
                    "type":type,
                    "file":imageurl
                  });
                  register();
              if (auth.currentUser != null && auth.currentUser!.email != null) {
    // Navigate to HomeScreen if email is not null
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const VerifyScreen(),
      ),
    );
  } else {
    // Navigate to LoginScreen if email is null
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen(),
      ),
    );
  }
                }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ],
          ),
        ),
      )),
    );
  }
}