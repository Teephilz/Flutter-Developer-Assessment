import 'package:flutter/material.dart';
class Buddies extends StatefulWidget {
  const Buddies({Key? key}) : super(key: key);

  @override
  State<Buddies> createState() => _BuddiesState();
}

class _BuddiesState extends State<Buddies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Buddies",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
