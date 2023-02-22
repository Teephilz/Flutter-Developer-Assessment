import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/bottom_bar_view.dart';
import 'package:flutter_assessment/provider/auth_provider.dart';
import 'package:flutter_assessment/widgets/my_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../verifyscreen/verifyscreen.dart';
import '../widgets/reusable_field_widget.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();


}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState>_formKey = GlobalKey<FormState>();


  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmpasswordTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();

  String sportType = "";
  String otpPin = "";



  final List<String> typeList = [
    'Football',
    'Basketball',
    'Ice Hockey',
    'Motorsports',
    'Bandy',
    'Rugby',
    'Skiing',
    'Shooting'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text("Sign Up",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24),),
          leading:
          IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInScreen()));
            },
            color: Colors.white,)


      ),
      body: Consumer<AuthProvider>(builder: (context,provider,c){
        return
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.deepOrangeAccent,
                      Colors.orangeAccent
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),

            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          reUsableTextFormField(
                            validator: (value) {
                              if (value
                                  .toString()
                                  .isEmpty) {
                                return "Enter your username";
                              }
                            },
                            controller: _usernameTextController,
                            text: "Enter Username",
                            icon: Icons.person_outline_rounded,
                            isObscure: false,
                            isPassword: false,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          reUsableTextFormField(
                            validator: (value) {
                              if (value
                                  .toString()
                                  .isEmpty) {
                                return "Enter your email address";
                              }
                            },
                            controller: _emailTextController,
                            text: "Enter Email",
                            icon: Icons.email,
                            isObscure: false,
                            isPassword: false,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.3)
                              ),
                              child: DropdownButtonFormField(
                                dropdownColor: Colors.orangeAccent,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.black54,
                                  labelStyle: TextStyle(fontSize: 21, color: Colors
                                      .white),
                                  focusColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                  ),
                                ),


                                icon: const Icon(Icons.expand_more),
                                alignment: AlignmentDirectional.bottomStart,
                                isExpanded: true,
                                value: typeList[0],
                                onChanged: (val) {
                                  setState(() {
                                    sportType = val!;
                                  });
                                },
                                items: typeList.map((String e) {
                                  return DropdownMenuItem(

                                    value: e,
                                    child: Text(e,
                                        style: TextStyle(color: Colors.white,
                                            fontSize: 17)),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          reUsableTextFormField(
                            validator: (value) {
                              if (value
                                  .toString()
                                  .isEmpty) {
                                return "Enter your psssword";
                              }
                              else if (value
                                  .toString()
                                  .length < 6) {
                                return "password should not be less than  6 characters";
                              }
                            },
                            controller: _passwordTextController,
                            text: "Enter Password",
                            icon: Icons.lock,
                            isObscure: true,
                            isPassword: true,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          reUsableTextFormField(
                            validator: (value) {
                              if (value
                                  .toString()
                                  .isEmpty) {
                                return "Confirm your password";
                              }
                              else if (value.toString()
                                  != _passwordTextController.text.trim()) {
                                return "Password does not match";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _confirmpasswordTextController,
                            text: "Confirm Password",
                            icon: Icons.lock,
                            isObscure: true,
                            isPassword: true,
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          //
                          reUsableTextFormField(
                            validator: (value) {
                            if (value
                                .toString()
                                .isEmpty) {
                            return "Enter your phone number";
                            }},
                            text: "Enter phone number",
                            controller: _phoneTextController,
                            icon: Icons.phone,
                            isObscure: false,
                            isPassword: false,
                            keyboardType: TextInputType.phone,
                          ),


                        ],
                      ),
                    ),

                    SizedBox(height: 40,),
                    signInsignUpButton(context, false, () {
                      if(_formKey.currentState!.validate()){
                        provider.SignUp(email: _emailTextController.text,
                            password:_passwordTextController.text,
                            name: _usernameTextController.text,
                            phonenumber:
                                _phoneTextController.text,
                            favouritesport: sportType,
                            context: context);
                      }
                      else{
                        Fluttertoast.showToast(msg: "Fill all details correctly");
                      }
                    }),
                    signInOption()
                  ],
                ),
              ),
            ),
          );
      }
    ));
  }
  Widget signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
          style: TextStyle(color: Colors.white70),),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LogInScreen()));
          },
          child: const Text(
            "Log In",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

          ),
        )
      ],
    );
  }


}
