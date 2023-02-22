import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/auth_screens/login_screen.dart';
import 'package:flutter_assessment/provider/auth_provider.dart';
import 'package:flutter_assessment/widgets/my_button.dart';
import 'package:flutter_assessment/widgets/reusable_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
class Settings extends StatefulWidget {
 TextEditingController _nameController=TextEditingController();
 TextEditingController _emailController=TextEditingController();
GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name='';
  String email='';

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AuthProvider>(context);
    provider.getUserData();
   final userList= provider.getUserList;

    try{
      name=userList.first.name.toString();
      email=userList.first.email.toString();
    }catch(e){
      name='';
      email='';
    }

    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Settings and Privacy",
          style: TextStyle(
              color: Colors.white
          ),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                          "Are you sure you want to log out?",
                          style: TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "cancel",
                                style: TextStyle(
                                    color: Colors.blueAccent),
                              )),
                          TextButton(
                              onPressed: () async {
                                const Center(
                                  child:
                                  CircularProgressIndicator(
                                    color: Colors.blueAccent,
                                  ),
                                );
                                await FirebaseAuth.instance
                                    .signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LogInScreen()));
                              },
                              child: const Text(
                                "Ok",
                                style: TextStyle(
                                  color:Colors.blueAccent,),
                              )),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.exit_to_app_outlined,
          color: Colors.white,))
        ],
      ),
      body: Center(
        child: Container(
          child: Form(
            key: widget._formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Edit Username and Email",
                  style: TextStyle(color: Colors.black,fontSize: 19,
                  fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
                  _buildSingleTextFormField(
                      name: name,
                      controller: widget._nameController,
                  validator: (value){
                        if(value.toString().isEmpty){
                          return " Enter your name";
                        }
                  }),
                  _buildSingleTextFormField(
                      name:  email,
                      controller: widget._emailController,
                        validator: (value) {
                          if (value
                              .toString()
                              .isEmpty) {
                            return " Enter your email address";
                          }
                        }),

                  MyButton(buttonName: "Save Edits", onPressed: (){
                    if(widget._formKey.currentState!.validate()){
                      provider.userDetailUpdate(
                          context,
                          widget._nameController.text,
                          widget._emailController.text);
                    }
                    else{
                      Fluttertoast.showToast(msg: "Fill all details correctly");
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSingleTextFormField({required String name, required TextEditingController controller,
  required FormFieldValidator validator}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: controller,
        validator: validator ,
        decoration: InputDecoration(
            hintText: name,
            hintStyle: TextStyle(color: Colors.black54),
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 1,),

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 1,),

            )
        ),
      ),
    );
  }
}
