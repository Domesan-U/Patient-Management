import "package:flutter/material.dart";
import 'package:patients/Admin.dart';
import 'package:patients/Search_Patient.dart';
import 'WelcomeScreen.dart';
import 'newpatient.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async { WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  //options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(start());
}
class start extends StatelessWidget {
  const start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: ThemeData(unselectedWidgetColor: Colors.black),
      debugShowCheckedModeBanner: false,

      home: AdminLogin(),
    );
  }
}
