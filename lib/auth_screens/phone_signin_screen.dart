import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/provider/auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../bottom_bar_view.dart';
import '../widgets/my_button.dart';
import '../widgets/reusable_field_widget.dart';
class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({Key? key}) : super(key: key);

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  TextEditingController _phoneController= TextEditingController();
  Country? country;
  String countrycode='+234';


  void dispose(){
    _phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
            countrycode="+${country!.phoneCode}";
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Verify Phone Number",
        style: TextStyle(color: Colors.white),),
        centerTitle: true,
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
            child: Text("Enter your phone number",
              style: TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,),
          ),
          SizedBox(
            height: 30,
          ),

          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                color: Colors.deepOrangeAccent,width: 1
                ),

              ),
              height: 60,
              child: Row(

                children: [
                  IconButton(onPressed: (){
                    pickCountry();
                  }, icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.deepOrangeAccent,size: 28,)),
                  TextButton(onPressed: (){
                    pickCountry();
                  },
                      child:Text(countrycode,
                      style: TextStyle(color: Colors.black,  fontSize: 18))),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _phoneController,
                      style: TextStyle(color: Colors.black,  fontSize: 18),
                      decoration: InputDecoration(
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white,
                          border: InputBorder.none
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(12.0),
                          //   borderSide:  BorderSide(color: Colors.deepOrangeAccent,width: 1, ),


                          // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0),
                          //   borderSide:  BorderSide(color: Colors.deepOrangeAccent, width: 1,),
                          //
                          // )
    ) ,
                    ),
                  ),
                ],
              ),
            ),
          ),


          MyButton(buttonName: "Verify",
              onPressed: () {
                if (_phoneController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter phone number");
                }
                else {
                  provider.verifyPhone(context, '${countrycode}${ _phoneController.text}');
                }
              })

        ],
      ),

    );
  }
}
