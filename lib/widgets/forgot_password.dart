import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/bottom_bar_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/reusable_field_widget.dart';
import '../auth_screens/login_screen.dart';
import 'my_button.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final GlobalKey<ScaffoldState>_scaffoldkey= GlobalKey<ScaffoldState>();

  TextEditingController _emailTextController= TextEditingController();

  void dispose(){
    _emailTextController.dispose();
    super.dispose();
  }


  Future passwordReset() async{
    if(_emailTextController.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter email address");
    } else {
    try {
      showDialog(
          context: context,
          builder: (context){
            return Center(child: CircularProgressIndicator());
          });
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text.trim());
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text("password reset link sent!"),
          );
        }).then((value) =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen())));

  } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldkey,
      appBar: AppBar(
        elevation:0.0,
        backgroundColor: Colors.deepOrangeAccent,
        leading:
          IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBarView()));
            },
            color: Colors.white,)
        ,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text("Enter your email address and we will send you a password to reset link",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,),
          ),
          SizedBox(
            height: 30,
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _emailTextController,
              style: TextStyle(color: Colors.black,  fontSize: 18),
              decoration: InputDecoration(prefixIcon: Icon(Icons.email,color: Colors.deepOrangeAccent,),
                 hintText: "Enter Email Address",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide:  BorderSide(color: Colors.deepOrangeAccent,width: 1, ),

                  ),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),
                      borderSide:  BorderSide(color: Colors.deepOrangeAccent, width: 1,),

                  )) ,
            ),
          ),
          MyButton(buttonName: "Reset",
          onPressed: (){
            if(_emailTextController.text.isEmpty){
              Fluttertoast.showToast(msg: "Enter your email address");
            }
            else{
              passwordReset();
            }

          })
        ],
      ),

    );
  }
}
