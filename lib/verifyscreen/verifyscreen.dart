import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/auth_screens/login_screen.dart';
import 'package:flutter_assessment/auth_screens/phone_signin_screen.dart';
import 'package:flutter_assessment/widgets/otp_screen.dart';



class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 320,
            width: MediaQuery.of(context).size.width * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    child: Image.asset(
                      'images/wel.png',
                      width: 130,
                      height: 100,
                      fit: BoxFit.cover,
                    )),
                 SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  height: 150,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "A verification link has been sent to your mail",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center),
                        Text(
                            "Kindly check your mail and verify to proceed to log in",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    final myContext = Navigator.of(context);
    user = auth.currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      timer?.cancel;
      myContext.pushReplacement(
          MaterialPageRoute(builder: (context) => PhoneSignIn()));
    }
  }
}
