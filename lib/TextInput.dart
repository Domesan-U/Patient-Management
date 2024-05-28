import 'package:flutter/material.dart';
class TextInput extends StatelessWidget {
  String? inputText;
  bool pass;
  Color? coloring;
  void Function(String) onClick;
  TextInput({required this.inputText,required  this.onClick ,required this.pass,this.coloring}){
       }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: (coloring!=null)? coloring:Colors.black),
      onChanged: onClick,
      cursorColor: Colors.red,
      obscureText: pass,
      decoration: InputDecoration(hintText: inputText,
          labelText: inputText,
          labelStyle: TextStyle(color: (coloring!=null)? coloring:Colors.black,fontStyle: FontStyle.italic),
         // hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(200),
              borderSide: BorderSide(color: Colors.black,width: 3.0)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(200),
              borderSide: BorderSide(color: Colors.black,width: 4.0)
          )
      ),
    );
  }
}
