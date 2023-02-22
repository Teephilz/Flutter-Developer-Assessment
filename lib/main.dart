import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/auth_screens/login_screen.dart';
import 'package:flutter_assessment/auth_screens/phone_signin_screen.dart';
import 'package:flutter_assessment/auth_screens/sign_up_page.dart';
import 'package:flutter_assessment/bottom_bar_view.dart';
import 'package:flutter_assessment/provider/auth_provider.dart';
import 'package:flutter_assessment/widgets/otp_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=> AuthProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        home:
        StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return LogInScreen();
              }
              else if(snapshot.hasData){
                return BottomBarView();
              }
              else
                return LogInScreen();
            }
        )
      ),
    );
  }
}