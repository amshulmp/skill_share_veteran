// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_veteran/Screens/Homescreen.dart';
import 'package:skill_share_veteran/Screens/detailscreen.dart';
import 'package:skill_share_veteran/Screens/login.dart';
import 'package:skill_share_veteran/config/styles.dart';
import 'package:skill_share_veteran/firebase/functions.dart';
import 'package:skill_share_veteran/widgets/button.dart';
import 'package:skill_share_veteran/widgets/textbox.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailcotroller = TextEditingController();
  TextEditingController passwordcotroller = TextEditingController();
  TextEditingController usernamecotroller = TextEditingController();
  TextEditingController repasswordcotroller = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sign up",
                  style: Styles.title(context),
                ),
              ),
              Text(
                "Welcome back.Please sign up using",
                style: Styles.subtitlegrey(context),
              ),
              Text(
                "your social account to continue",
                style: Styles.subtitlegrey(context),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Textbox(
                hideText: false,
                tcontroller: emailcotroller,
                type: TextInputType.emailAddress,
                hinttext: 'Email',
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Textbox(
                hideText: false,
                tcontroller: usernamecotroller,
                type: TextInputType.name,
                hinttext: 'Username',
                icon: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Textbox(
                hideText: true,
                tcontroller: passwordcotroller,
                type: TextInputType.visiblePassword,
                hinttext: 'Password',
                icon: Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Textbox(
                hideText: true,
                tcontroller: repasswordcotroller,
                type: TextInputType.visiblePassword,
                hinttext: 'Confrm password',
                icon: Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              CustomLoginButton(
                  text: "Next",
                  onPress: () async {
                    if (emailcotroller.text.trim().isEmpty ||
                        passwordcotroller.text.trim().isEmpty ||
                        usernamecotroller.text.trim().isEmpty ||
                        repasswordcotroller.text.trim().isEmpty) {
                      scaffoldMessengerKey.currentState!.showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }

                    if (passwordcotroller.text.trim() !=
                        repasswordcotroller.text.trim()) {
                      scaffoldMessengerKey.currentState!.showSnackBar(
                        const SnackBar(
                          content: Text('Passwords do not match.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }

                     await createuser({
                      "email": emailcotroller.text.trim(),
                      "password": passwordcotroller.text.trim(),
                      "username": usernamecotroller.text.trim(),
                    "isverified":false,
                      "timestamp":Timestamp.now()
                    });
             
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DetailsScreen(),
                        ),
                      );
                  }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


