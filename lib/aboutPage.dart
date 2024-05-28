import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
class AboutPage extends StatelessWidget {
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF4532E4),
          title: Text('About Us'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 80.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 27.0,
                        color: Colors.black,
                        fontFamily: 'NerkOne',
                      ),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Row(
                          children: [
//                   Text("Domesan's",style: TextStyle(fontSize: 35.0,fontFamily: 'Horizon',color: Colors.black),)
// ,
                            Flexible(
                              child: AnimatedTextKit(
                                stopPauseOnTap: false,
                                animatedTexts: [
                                  RotateAnimatedText("  DOMESANS PLATFORM",textStyle: TextStyle(color: Color(0XFF6C06DB),fontFamily: 'NerkOne')),
                                ],
                                onTap: () {
                                },
                                repeatForever: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),   //     style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Container(
                            color: Color.fromRGBO(231,228,214,1.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      ColorizeAnimatedText('Creator',colors: colorizeColors,speed: Duration(milliseconds:500 ),textStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25.0,fontFamily: 'NerkOne'),)
                                    ],
                                    onTap: () {
                                      print("Tap Event");
                                    },
                                  ),
                                  Text('\nI am a Computer \n'
                                      'Science Student. \n'
                                      'Currently Working on \n'
                                      'Flutter Independently.'
                                      '\nCreated Several apps    '
                                      '\nusing flutter and'
                                      '\nworked in developing'
                                      '\nWebsite Independently'
                                      '\n                 -Domesan',style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Handle'),)
                                ],
                              ),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Container(
                            color: Color.fromRGBO(243,218,196,1.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      ColorizeAnimatedText('Vision',colors: colorizeColors,speed: Duration(milliseconds:500 ),textStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25.0,fontFamily: 'NerkOne'),)
                                    ],
                                    onTap: () {
                                      print("Tap Event");
                                    },
                                  ),
                                  Text('\nAim is to develop \n'
                                      'User-Friendly and long- \n'
                                      'term apps and to make it '
                                      '\navailable free for anyone'
                                      '\nfrom anywhere and main \n'
                                      'motto is To be interative  '
                                      '\nwith the user\n\n',style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Handle'))
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Container(
                            color: Color.fromRGBO(231,228,214,1.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      ColorizeAnimatedText('Publication',colors: colorizeColors,speed: Duration(milliseconds:500 ),textStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25.0,fontFamily: 'NerkOne'),)
                                    ],
                                    onTap: () {
                                      print("Tap Event");
                                    },
                                  ),
                                  Text('\nUntil Now, This App\n'
                                      'is not published for  \n'
                                      'Public usage. Using\n'
                                      'this without the '
                                      '\nconcern of the Creator'
                                      '\nis completely illegal '
                                      '\n'
                                      '\n'
                                      '\n',style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Handle'))
                                ],
                              ),
                            ),
                          ),
                        ]),
                        Column(children: [
                          Container(
                            color: Color.fromRGBO(243,218,196,1.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      ColorizeAnimatedText('Query',colors: colorizeColors,speed: Duration(milliseconds:500),textStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25.0,fontFamily: 'NerkOne'),)
                                    ],
                                    onTap: () {
                                      print("Tap Event");
                                    },
                                  ),
                                  Text('\nDid you encounter\n'
                                      'any problem? please\n'
                                      'mention your problem'
                                      '\nto us through  \n'
                                      'domesandms@gmail.com   \n'
                                      '\n\n\n',style: TextStyle(fontWeight: FontWeight.w600 ,fontFamily: 'Handle'))
                                ],
                              ),
                            ),
                          ),
                        ]),

                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
