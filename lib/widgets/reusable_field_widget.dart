import 'package:flutter/material.dart';
class reUsableTextFormField extends StatefulWidget {
  String? text;
  IconData? icon;
  bool? isObscure;
  bool? isPassword;
  TextEditingController? controller;
   FormFieldValidator? validator;
  TextInputType? keyboardType;


  reUsableTextFormField({
  this.text, this.icon, this.isObscure, this.isPassword, this.controller, this.validator, this.keyboardType
});

  @override
  State<reUsableTextFormField> createState() => _reUsableTextFormFieldState();
}

class _reUsableTextFormFieldState extends State<reUsableTextFormField> {

  void _togglePassword(){
    setState(() {
      widget.isObscure = !widget.isObscure!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return widget.isPassword== false? TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscure!,
      cursorColor: Colors.white,
      validator: widget.validator,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(prefixIcon: Icon(widget.icon,color: Colors.white,),
          labelText: widget.text,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)
          )) ,
      keyboardType: widget.keyboardType ,
    )
        :
    TextFormField(
        controller:widget.controller ,
        obscureText: widget.isObscure! ,
        validator: widget.validator,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock,color: Colors.white,),
          suffixIcon: InkWell(
            onTap: (){
              _togglePassword();
            },
            child:widget.isObscure!? Icon(Icons.visibility,color: Colors.white,
            ): Icon(Icons.visibility_off,color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),

          labelText:"Enter password",
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),


        ),
    keyboardType: widget.keyboardType,);
  }
}


Widget phoneField(BuildContext context, String countryCode, Function()? onTap, TextEditingController controller){
  return Container(
    height: 60,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Expanded(
      child: Row(
      children: [
        IconButton(onPressed: onTap, icon: Icon(Icons.arrow_drop_down, color:Colors.white,size: 35,)),
        Text(countryCode),
        SizedBox(width: 5,),
        SizedBox(
          width: 200,
          child: Expanded(
            child: TextFormField(

              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                  hintText: "PhoneNumber",
                hintStyle: TextStyle(color: Colors.white)
              ),
        ),
          ) ),


],

      ),
    ),
  );
}


 Widget signInsignUpButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      child: ElevatedButton(onPressed: () {
        onTap();
      },
          child: Text(isLogin ? 'LOG IN' : 'SIGN UP',
            style: TextStyle(color: Colors.black87,
                fontWeight: FontWeight.bold, fontSize: 16),),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Colors.white;
            }
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
          )
      )
  );
}