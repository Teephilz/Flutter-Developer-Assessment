import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../auth_screens/login_screen.dart';
import '../provider/auth_provider.dart';
import 'my_button.dart';
class OtpScreen extends StatelessWidget {
 String otpPin="";
 String phoneNumber;
 OtpScreen({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
      ),

      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "An OTP has been sent to" + " ",
                      style: TextStyle(fontSize: 18,
                      color: Colors.black)
                  ),
                  TextSpan(
                      text: phoneNumber,
                      style: TextStyle(fontSize: 18,
                          color: Colors.black)
                  ),
                  TextSpan(
                      text:" "+ "Enter the 6-digit code to continue",
                      style: TextStyle(fontSize: 18,
                          color: Colors.black)
                  ),


                ],

              ),
            ),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/12),
              child: PinCodeTextField(appContext: context,
                length: 6,
                onChanged: (value){
                  otpPin = value;
                },
                pinTheme: PinTheme(
                    activeColor: Colors.orangeAccent,
                    selectedColor: Colors.deepOrangeAccent,
                    inactiveColor: Colors.black
                ),),
            ),
            MyButton(buttonName: "Verify", onPressed: (){
             provider.verifyOTP(context: context, otpPin: otpPin);
            })
          ],
        ),
      )
    );
  }
}
