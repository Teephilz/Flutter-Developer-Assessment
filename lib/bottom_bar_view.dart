import 'package:flutter/material.dart';

import 'menus/buddies.dart';
import 'menus/discover.dart';
import 'menus/profile.dart';
import 'menus/settings.dart';

class BottomBarView extends StatefulWidget {
  BottomBarView({Key? key}) : super(key: key);

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> widgetOption = [
   Profile(),
    Buddies(),
    Discover(),
    Settings()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          // height: 50,
          child: BottomNavigationBar(
            onTap: onItemTapped,
            selectedItemColor: Colors.black,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                  color: currentIndex ==0? Colors.deepOrangeAccent:Colors.black,),
                  label: 'Profile'),
              BottomNavigationBarItem(
                  icon:Icon(Icons.people,
                    color: currentIndex ==1? Colors.deepOrangeAccent:Colors.black,),
                  label: 'Buddies'),
              BottomNavigationBarItem(
                  icon:Icon(Icons.find_in_page,
                    color: currentIndex ==2? Colors.deepOrangeAccent:Colors.black,),
                  label: 'Discover'),

              BottomNavigationBarItem(
                  icon: Icon(Icons.settings,
                    color: currentIndex ==3? Colors.deepOrangeAccent:Colors.black,),
                  label: 'Settings'),

    ])),
        body: widgetOption[currentIndex]);
  }
}
