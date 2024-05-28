import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Text("OOPS... We are sorry",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("The searched patient is not found. \n"
                  "Try adding the patient using the new patient button below",style: TextStyle(fontWeight: FontWeight.w500),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Material(
              elevation: 300,
              textStyle: TextStyle(
                fontWeight: FontWeight.w900,
              ),
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(300),
              child: MaterialButton(
                child: Text(
                  "Back",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      fontStyle: FontStyle.italic),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  },
              ),
            ),
          ),


        ],
      ),
    );
  }
}
