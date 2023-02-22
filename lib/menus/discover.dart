import 'package:flutter/material.dart';
class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Discover",style: TextStyle(
            color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
