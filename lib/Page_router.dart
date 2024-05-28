import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:patients/newpatient.dart';
import 'package:patients/Search_Patient.dart';
import 'Admin.dart';
import 'ProjectList.dart' as pro;
import 'package:firebase_core/firebase_core.dart';
import 'aboutPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
// class PageRouter extends StatelessWidget {
//   const PageRouter({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
//
final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

String message = "";
int isTrue =0;
class PageRouter extends StatefulWidget {
  List? Project;
  PageRouter({this.Project}){
    print("ProjectList in Page_Router ${pro.Doctor}");

  }
  @override
  State<PageRouter> createState() => _PageRouterState();
}


class _PageRouterState extends State<PageRouter> {
  @override
  void caller(){
    setState((){
      isTrue;
      print("caller called");
    });
  }
  int appBarPresser = 1;
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarPresser = 1;
    print("building page_router");
    if (_auth.currentUser != null) {
      print("Entered New Patient page");
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
    }
  }

  Widget build(BuildContext context) {
    return Container(
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
          appBar: AppBar(
            actions: [
             Padding(
               padding: const EdgeInsets.all(12.0),
               child: MaterialButton(
                 child: Icon(Icons.menu_sharp,color: Colors.white,size: 40,
                  ),
                 onPressed: (){
                   setState(() {
                    if(appBarPresser==0)
                      {appBarPresser =1;}
                    else if(appBarPresser == 1)
                      {
                        appBarPresser =0;
                      }

                   });

                 },
               ),
             )

            ],
            backgroundColor: Colors.transparent,
            title: Text("Admin Page"),
          ),
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                IndexedStack(
                  index: appBarPresser,
                  children:[
                    WillPopScope(child: Container(), onWillPop: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>pro.Project())); return Future.value(true);}),
                    Container(
                      alignment: Alignment.topRight,
                      height: 126,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          width: 100,
                          color: Colors.grey,
                          child: ListView(children: [
                            Container(height:30 ,width:MediaQuery.of(context).size.width,color:Colors.grey,child: Material(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(200),
                              elevation: 200,
                              child: MaterialButton(color:Colors.grey,onPressed: (){
                                ExcelCreater();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Excel()));
                              }, child: Text("Download data",style: TextStyle(color: Colors.white),)),
                            )),
                            Container(width:30,child: Divider(color: Colors.white,height: 2,thickness: 1,)),
                            Container(height:30 ,width:MediaQuery.of(context).size.width,child: Material(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(300),
                              child: MaterialButton(color:Colors.grey,onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
                              }, child: Text("About",style: TextStyle(color: Colors.white),)),
                            )),
                            Container(width:30,child: Divider(color: Colors.white,height: 2,thickness: 1,)),
                            Container(height:30 ,width:MediaQuery.of(context).size.width,child: MaterialButton(color:Colors.grey,onPressed: (){
                              _auth.signOut();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
                            }, child: Text("Logout",style: TextStyle(color: Colors.white),))),
                            Divider(color: Colors.white,height: 2,thickness: 1,),

                          ],),
                        ),
                      ),
                    ),Container()
                  ]


                ),
                Flexible(
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(message,style:TextStyle(color:Colors.green)),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                              child: Material(
                                elevation: 30,
                                color: Color(0XFF1D1D2A),
                                borderRadius: BorderRadius.circular(300),
                                child: MaterialButton(
                                  minWidth: 200,
                                  height: 60,
                                  child: Text("New Patient",style: TextStyle(color: Colors.white,fontSize: 20.0
                                  ),),
                                  onPressed:   (){
                                    setState(() {
                                      if(isTrue == 1)
                                      {
                                        message= "Succesfully added";
                                      }
                                    });
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>newpatient(p_name:'',id:'',CdateList:[],tabList:[]))).whenComplete((){
                                      caller();
                                      print("completed");
                                    });
                                    print("isTrue $isTrue");
                                  }
                                  ,
                                ),
                              ),      ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(48.0),
                            child: Center(
                              child:  Material(
                                elevation: 30,
                                color: Color(0XFF1D1D2A),
                                borderRadius: BorderRadius.circular(300),
                                child: MaterialButton(
                                  minWidth: 200,
                                  height: 60,
                                  child: Text("Search Patient",style: TextStyle(color: Colors.white,fontSize: 20.0
                                  ),),
                                  onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPatient()));


    },
                                ),
                              ),                   ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );;
  }
}
