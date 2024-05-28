import 'package:flutter/material.dart';
import 'package:patients/Admin.dart';
import 'TextInput.dart';
import 'Page_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
String ProjectName ="";
String Village = "";
String Doctor ="";
String Nurse = "";
String F_Incharge = "";
List VillageList =[
  "ayyanpettai",
  "mutiyalpettai",
  "nasarathPettai",
  "arcodu",
  "cheyyar",
  "chengalpattu",
  "sriperumbatur"
];
final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
void getPatients() async {
  print("Entered method");
  await for (var snapshot in _firestore.collection("patients").snapshots()) {
    for (var message in snapshot.docChanges) {
      VillageList.add(message.doc.data()!['village'].toString().toLowerCase().replaceAll(" ", ""));
     VillageList =  VillageList.toSet().toList();
     VillageList.sort();
      }
    print("INside method ${VillageList}");

  }
}

final VillageTextController = TextEditingController();
class Project extends StatefulWidget {
 List getter(){
   List Lister = [ProjectName,Doctor];
   return Lister;
 }
  @override
  State<Project> createState() => _ProjectState();
}
class _ProjectState extends State<Project> {

int showSearchIndex = 1;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_auth.currentUser != null) {
    } else {
      Navigator.pop(context);
    }
    getPatients();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
          // image: DecorationImage(
          //     image: AssetImage("images/patient.jpg"),
          //     fit: BoxFit.cover
      //)
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.black54,
              ]
          ),),

        child: Scaffold(
            appBar: AppBar(
              title: Text("Project Details"),
              backgroundColor: Colors.black38,
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  WillPopScope(child: Container(), onWillPop: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin())); return Future.value(true);}),
                  Row(
                    children: [
                      Column(
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(left:18.0),
                        child: Icon(Icons.work_outline_rounded,size: 30,),
                      ),
                        ]
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left:10.0,right: 40.0,top:30,bottom: 30),
                            child: TextInput(inputText: "Enter Project Name", onClick: (value){
                              setState((){  ProjectName = value;
                                showSearchIndex = 1;
                              });
                              print("ShowSearch $showSearchIndex");

                            },pass: false,coloring: Colors.white)
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:18.0),
                        child: Icon(Icons.home_outlined,size: 30,),
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left:10.0,right: 40.0,top:30,bottom: 30),
                            child: TextFormField(
                              controller: VillageTextController,
                              style: TextStyle(color:Colors.white),
                              onChanged: (value){setState(() {
                                getPatients();
                                print("Here ${VillageList.toSet().toList()}");
                                showSearchIndex = 0;
                                Village = value;
                              });
                              print("ShowSearch $showSearchIndex");
                              },
                              onEditingComplete: (){
                                setState(() {
                                  showSearchIndex  =1;
                                });
                              },
                              cursorColor: Colors.red,
                              decoration: InputDecoration(
                                  labelText: "Enter your Village name",
                                  labelStyle: TextStyle(color: Colors.white,fontStyle: FontStyle.italic),
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
                            ),
                        ),
                      ),
                    ],
                  ),
                  IndexedStack(
                    index: showSearchIndex,
                    children: [
                      Container(
                        height: 80,
                        child: ListView.builder(itemCount:VillageList.length,itemBuilder: (context,index){return
                          (Village=="")?Container():(VillageList[index].toLowerCase().replaceAll(" ", "").contains(Village))?TextButton(onPressed: (){
                            setState(() {
                              VillageTextController.text = VillageList[index];
                              Village = VillageList[index];
                            });
                          }, child: Text(VillageList[index],style: TextStyle(color: Colors.white,),)):Container();
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10.0,left:50,right:40),
                        child: Center(
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.warning_amber_sharp,color: Colors.white,),
                                ),
                                Expanded(
                                  child: Text(
                                    "Here Searching is based on Village name careful on your village name entry",style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: IconButton(icon: FaIcon(FontAwesomeIcons.userDoctor),iconSize: 25, onPressed: () {  },),
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left:0.0,right: 40.0,top:30,bottom: 30),
                            child: TextInput(inputText: "Enter Doctor Name", onClick: (value){
                              setState((){ Doctor = value;
                              showSearchIndex = 1;
                              });
                            },pass: false,coloring: Colors.white)
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: IconButton(icon: FaIcon(FontAwesomeIcons.userNurse),iconSize: 25, onPressed: () {  },),
                      ),

                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left:0.0,right: 40.0,top:30,bottom: 30),
                            child: TextInput(inputText: "Enter Nurse Name", onClick: (value){
                              setState((){    Nurse = value;
                              });
                            },pass: false,coloring: Colors.white)
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: IconButton(icon: FaIcon(FontAwesomeIcons.circleUser),iconSize: 25, onPressed: () {  },),
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left:0.0,right: 40.0,top:30,bottom: 30),
                            child: TextInput(inputText: "Enter Field Incharge Name", onClick: (value){
                              setState((){F_Incharge = value;
                              });
                              },pass: false,coloring: Colors.white)
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Material(
                        elevation: 30,
                        color: Color(0XFF1D1D2A),
                        borderRadius: BorderRadius.circular(300),
                        child: MaterialButton(
                          minWidth: 200,
                          height: 60,
                          child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 20.0
                          ),),
                          onPressed:   (){
                            print("WIdget ${ProjectName}");
                            print("List above her${widget.getter()}");
                           //checker(doctor:Doctor).get();
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>PageRouter()));
                            VillageTextController.clear();
                          }

                          ,
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            )
        ),
      ),
    );
  }
}

class checker extends StatelessWidget {
  String? doctor;
  checker({this.doctor});
  void get(){
    print("List down here$doctor");
   print( Project().getter());
   noobchecker().getnoob();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
class noobchecker {
  void getnoob(){
    print("Noob checker");
    //print(commonDoctor);
    print("Doc $Doctor");
    print("Project $ProjectName");
  }
}
