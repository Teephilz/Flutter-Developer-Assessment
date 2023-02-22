import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  String buttonName;
  void Function()? onPressed;

  MyButton({required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(

            height: 50,
            width: 150,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
            ),
            child: ElevatedButton(onPressed: onPressed,
                child: Text(buttonName,
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 16),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.black26;
                      }
                      return Colors.deepOrangeAccent.withOpacity(0.7);
                    }
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                )
            )
        );
  }
}
