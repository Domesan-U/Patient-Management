import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patients/Page_router.dart';
import 'package:patients/Search_Patient.dart';
import 'TextInput.dart';
import 'package:patients/Register.dart';
import 'ProjectList.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
final _auth = FirebaseAuth.instance;
String email="";
String pass="";
String e_message ="";
class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  static const colorizeColors = [
    Colors.blue,
    Colors.blue,
    Colors.yellow,
    Colors.red
  ];
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivated");
    e_message ="";
    email = "";
    pass ="";
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.blueGrey
        //image:
        //DecorationImage(image: AssetImage("images/patient.jpg"),
          //fit: BoxFit.cover
        //)
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black54,
            Colors.black87,
          ]
        ),),
        child: Scaffold(

          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                WillPopScope(child: Container(), onWillPop: (){print("pressed Admin back"); return Future.value(false);}),
            Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: AnimatedTextKit(
                          stopPauseOnTap: false,
                          animatedTexts: [
                            ColorizeAnimatedText("Admin Login",textStyle: TextStyle(color: Color(0XFF6C06DB),fontFamily: 'NerkOne',fontSize: 40,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),colors: colorizeColors),
                          ],
                          onTap: () {
                          },
                          repeatForever: true,
                        ),),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: TextInput(inputText: "Enter your mail", onClick: (value){
                        setState(() {
                          e_message = "";
                          print("Inside Text Input $value");
                          });
                        email = value;
                      },pass: false,coloring: Colors.white)
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 25, 40, 40),
                      child: TextInput(inputText:  "Enter your Password",onClick: (value){
                        setState(() {
                          e_message="";
                        });
                        pass = value;
                      },pass: true,coloring: Colors.white,),
                    ),
                    Text(
                      e_message,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: Material(
                          borderRadius: BorderRadius.circular(300),
                          //color: Color(0XFF1D1D2A),
                          color:Colors.black38,
                          child: MaterialButton(
                            height: 60.0,
                            minWidth: 200.0,
                            //padding: EdgeInsets.all(14.0),
                            onPressed: () async {
                               UserCredential user ;
                               try {
                                print("pressed");
                                 user = await _auth.signInWithEmailAndPassword(
                                    email: email.replaceAll(" ", ""), password: pass.replaceAll(" ", ""));
                                print("here USer $user");
                                print("succesfull");
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  e_message = "";
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => Project()));
                                });}
                              on FirebaseAuthException catch(e)
                              {if(e.code=="unknown")
                                {
                                  setState(() {
                                    print("reached credentials");
                                    e_message ="Enter proper Credentials";
                                  });
                                }
                                else if(e.code == "user-not-found")
                                  {
                                    setState(() {
                                      print("reached user not found");
                                      e_message = "Enter valid mail id";
                                    });
                                  }
                                else
                                  {
                                    setState(() {
                                      e_message = e.code;
                                    });
                                     }
                                print("Inside Admin catch ${e.code}");
                             //print("here USer $user");
                              }
                              email = "";
                              },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text("Not a User?  Register"),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterC()));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

