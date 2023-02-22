import'package:flutter/material.dart';
import 'package:flutter_assessment/provider/auth_provider.dart';
import 'package:provider/provider.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name='';
  String phoneNumber='';
  String favouriteSport='';
  String email='';

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AuthProvider>(context);
    try{
        name=provider.getUserList.first.name.toString();
        phoneNumber=provider.getUserList.first.phoneNumber.toString();
        favouriteSport=provider.getUserList.first.favouriteSport.toString();
        email=provider.getUserList.first.email.toString();
    }catch(e){
          name='';
          phoneNumber='';
          favouriteSport='';
          email='';
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Profile",
          style: TextStyle(
              color: Colors.white
          ),),
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(builder: (context,provider,c){
        provider.getUserData();
        return Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: CircleAvatar(
                      child: Image.asset("images/userimage.png"),
                    ),
                  ),
                  _buildSingleContainer(startText: "Username",
                      endText: name),
                  _buildSingleContainer(startText: "Email",
                      endText: email),
                  _buildSingleContainer(startText: "Phone Number",
                      endText: phoneNumber),
                  _buildSingleContainer(startText: "Favourite Sport",
                      endText: favouriteSport),

                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.35,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orangeAccent,
                        width: 1,
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Taiwo Philip, Oyelakin',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),),
                          Text("oyetaiwophilip@gmail.com",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue,
                              fontSize: 15),),
                          SizedBox(height: 10,),
                          Text("Taiwo Philip Oyelakin is a flutter developer with two years of experience in apps development well proficient with flutter framework(Android Studio, Visual Studio code, Dart programming language, REST API, sqflite and firebase backend )."
                              "In the last few months, I have been able to singlehandedly work on some projects including creation of an E-commerce Multi-store  app with admin support,push notifications and paystack payment integration,"
                              "" "Event Mangement app with chatting function and stripe payment integration,"
                              " ,"
                              "I would be glad if given the opportunity to work in your company, as I am willing  to collaborate with team and learn new ideas for the growth and progress of the company  ",
                            textAlign: TextAlign.start,
                            style: (TextStyle(

                              wordSpacing: 2,
                              fontSize: 12
                            )),
                          ),
                        ],
                      ),
                    )
                  )

                ],
              ),
            ),
          ),
        );
      },)
    );
  }

  Widget _buildSingleContainer(
      {required String startText, required String endText}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20 )
        ),
        child: Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(startText, style: TextStyle(
                  fontSize: 17, color: Colors.black45
              ),),
              SizedBox(width: 30,),
              Expanded(
                child: Text(endText, style: TextStyle(
                    fontSize: 17, color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),

        ),
      ),
    );
  }
}
