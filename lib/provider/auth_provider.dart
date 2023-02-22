
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:flutter_assessment/auth_screens/login_screen.dart';
import 'package:flutter_assessment/models/user_model.dart';
import 'package:flutter_assessment/widgets/otp_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bottom_bar_view.dart';
import '../verifyscreen/verifyscreen.dart';
class AuthProvider extends ChangeNotifier{

  String verID="";
  List<UserModel> users=[];
  UserModel? model;

  Future<void>verifyPhone(BuildContext context,String number) async{
    showDialog(context: context,
        builder:(context){
          return Center(child: CircularProgressIndicator());
        });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        timeout: Duration(minutes: 1 ),
        verificationCompleted:(PhoneAuthCredential credential){
          Fluttertoast.showToast(msg: "Auth Completed");
        },
        verificationFailed: (FirebaseAuthException e){
          Fluttertoast.showToast(msg: "Auth Failed");
        },
        codeSent: (String verificationId,int? resendToken){
          Fluttertoast.showToast(msg: "Otp sent");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen(phoneNumber: number)));

          verID=verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationID){
          Fluttertoast.showToast(msg: "TimeOut!");
        });
  }

  Future<void>verifyOTP({required BuildContext context,required String otpPin })async{
    showDialog(context: context,
        builder:(context){
          return Center(child: CircularProgressIndicator());
        });
    await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verID,
            smsCode: otpPin)
    ).whenComplete(() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInScreen()), (route) => false));
  }

  Future <void> SignUp({required String email,password, name, phonenumber,favouritesport,
  required BuildContext context}) async {
      try {
        showDialog(context: context,
            builder: (context) {
              return Center(child: CircularProgressIndicator());
            });
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email,
            password: password);
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => VerifyScreen()), (
            route) => false);

        FirebaseFirestore.instance.collection("users")
            .doc(result.user?.uid)
            .set({
          "userID": result.user?.uid,
          "userName": name,
          "userEmail":email,
          "userPhoneNumber": phonenumber,
          "favouriteSport": favouritesport
        }
        );
      }
      on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: e.message.toString());
      };
  }

  Future<void> SignIn ({required String email,password,
    required BuildContext context})async {
      try{
        showDialog(context: context,
            builder:(context){
              return Center(child: CircularProgressIndicator());
            });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password:password);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomBarView()), (route) => false);
      } on FirebaseAuthException catch(e){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: e.message.toString());
      }

  }

  Future<void> userDetailUpdate(BuildContext context,String name, email) async{

    showDialog(context: context,
        builder:(context){
          return Center(child: CircularProgressIndicator());
        });
    User? user = FirebaseAuth.instance.currentUser;

    await  FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
        "userName": name,
        "userEmail": email,
      }).whenComplete(() {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomBarView()), (route) => false);
    });
    notifyListeners();
    }


  Future<void>getUserData()async {
    List<UserModel>newList=[];
    User? user= FirebaseAuth.instance.currentUser;
    QuerySnapshot userdata= await FirebaseFirestore.instance.collection("users")
        .where("userID",isEqualTo: user!.uid).get();
    userdata.docs.forEach((element) {
      model= UserModel(
        uid:element["userID"],
        name: element["userName"],
        phoneNumber: element["userPhoneNumber"],
        email: element["userEmail"],
        favouriteSport: element["favouriteSport"]
      );
      newList.add(model!);
    });
    users=newList;
    notifyListeners();
  }

  List<UserModel> get getUserList{
    return users;
  }

}