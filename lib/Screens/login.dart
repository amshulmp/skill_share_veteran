import 'package:flutter/material.dart';
import 'package:skill_share_veteran/Screens/forgotpassword.dart';
import 'package:skill_share_veteran/Screens/homescreen.dart';
import 'package:skill_share_veteran/Screens/register.dart';
import 'package:skill_share_veteran/config/styles.dart';
import 'package:skill_share_veteran/firebase/functions.dart';
import 'package:skill_share_veteran/widgets/button.dart';
import 'package:skill_share_veteran/widgets/textbox.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcotroller = TextEditingController();
  TextEditingController passwordcotroller = TextEditingController();
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
                  "Sign in",
                  style: Styles.title(context),
                ),
              ),
              Text(
                "Welcome back.Please sign in to",
                style: Styles.subtitlegrey(context),
              ),
              Text(
                "continue",
                style: Styles.subtitlegrey(context),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Textbox(
                hideText: false,
                tcontroller: emailcotroller,
                type: TextInputType.emailAddress,
                hinttext: 'Email',
                icon: Icon(Icons.email,color:Theme.of(context). colorScheme.onPrimary,),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Textbox(
                hideText: true,
                tcontroller: passwordcotroller,
                type: TextInputType.visiblePassword,
                hinttext: 'Password',
                icon:Icon(Icons.lock,color:Theme.of(context). colorScheme.onPrimary,),
              ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.013),
             SizedBox(height: MediaQuery.of(context).size.height * 0.013),
             
             
              CustomLoginButton(
                  text: "Sign in",
                  onPress: () async{
                await signin(emailcotroller.text.trim(), passwordcotroller.text.trim());
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>const HomeScreen(),
                      ),
                    );
                  }),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("don't have an account?"),
                      TextButton(onPressed: (){
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const RegisterScreen(),
                      ),
                    );
                      }, child: Text("Sign up", style: TextStyle(color: Theme.of(context).colorScheme.primary),))
                    ],
                  )
            ],
          ),
        ),
      ),
    );
  }
}
