import 'package:flutter/material.dart';
import 'Admin.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage('images/patient.jpg'),opacity: 0.7,
            fit: BoxFit.cover,
          ),
        ),
         child: Container(
           decoration: BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.center,
               end: Alignment.bottomCenter,
               colors: [
                 Colors.black45,
                 Colors.black45,
               ]
             )
           ),
           child: Scaffold(
             backgroundColor: Colors.transparent,
             body: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Padding(
               padding: const EdgeInsets.all(18.0),
                   child: Center(
                     child: AnimatedButton(
                       onPress: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
                       },
                       backgroundColor: Color(0XFF1D1D2A),
                       selectedBackgroundColor: Color(0XFF1D1D2A),
                       borderRadius: 300,
                       height: 60,
                       width: 200,
                       text: 'Admin Login',
                       isReverse: true,
                       selectedTextColor: Colors.black,
                       transitionType: TransitionType.LEFT_BOTTOM_ROUNDER,
                       textStyle: TextStyle(
                           color: Colors.white,
                           fontSize: 20.0
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(48.0),
                   child: Center(
                     child:  AnimatedButton(

                       onPress: (){},
                       backgroundColor: Color(0XFF1D1D2A),
                        selectedBackgroundColor: Color(0XFF1D1D2A),
                       borderRadius: 300,
                       height: 60,
                       width: 200,
                       text: 'About',
                       isReverse: true,
                       selectedTextColor: Colors.black,
                       transitionType: TransitionType.LEFT_BOTTOM_ROUNDER,
                       textStyle: TextStyle(
                           color: Colors.white,
                         fontSize: 20.0
                          ),
                     ),                   ),
                 ),

               ],
             )
           ),
         )
      );

  }
}
