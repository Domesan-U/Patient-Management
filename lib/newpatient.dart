import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:patients/Admin.dart';
import 'package:patients/ProjectList.dart';
import 'package:patients/Search_Patient.dart';
import 'package:patients/fetch_records.dart';
import 'TextInput.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ProjectList.dart' as pro;
import 'package:patients/Page_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
int mainIndex =0;
final _controller = ScrollController();
String patientName = "";
String? SelectedValue;
List groupOfTablets = [
  'paracetamol',
  'crocin',
  'aspirin',
  'Aceclo',
  'dolo 650',
  'Amoxicillin',
  'Albendazole Sus',
  'B.Complex. Cap',
  'Cetrazin.Tab'
      'Calcium500Mg.Tab',
  'Domperidone.Tab'
      'Domperidone.Sus'
];
int indexValue = 1;
DateTime? date;
int count = 1;
Map k_Main_tablet_list = {};
Map k_final_list = {};
String? label;
String Sex = "";
bool Mrng = false;
List<TextEditingController> _controllers = [];
bool Noon = false;
bool Evng = false;
bool Night = false;
List<DropdownMenuItem<String>> DropDownList = [DropdownMenuItem(child:Text("Male"),value: "M"),DropdownMenuItem(child:Text("Female"),value: "F")];
List<ListWidget>? lister;
List Tablets = [];
String filterTablet = "";
final tabletController = TextEditingController();
List dateList = [];
FieldValue datetime = FieldValue.serverTimestamp();
double? S_height;
double? S_width;
String messageAbtPatient = "";
bool isPresentAlready1 = false;
final nameController = TextEditingController();
String docId = "";
ScrollController _scrollController = new ScrollController();
final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
bool isPresentAlready = false;
class newpatient extends StatefulWidget {

  String p_name = "";
  newpatient(
      {required this.p_name,
        required String id,
        required List CdateList,
        required List tabList}) {
    print("new patient Constructor first ${pro.Village}");
    isPresentAlready1 = false;
    Tablets = tabList;
    dateList = CdateList;
    if (p_name != "") {
      nameController.addListener(() {
        nameController.text = patientName;
      });
      print("fetched CdateList inside newPatient $dateList");
      docId = id;
      patientName = p_name;
      isPresentAlready1 = true;
   }
  }
  @override
  State<newpatient> createState() => _newpatientState();
}

class _newpatientState extends State<newpatient> {
  String symptoms = "";
  int callListWidget = 1;
  String p_tion = "";
  String bp = '';
  String height = "";
  String weight = "";
  String age = "";
  void getPatients(String patientName) async {
    print("Entered method");
    await for (var snapshot in _firestore.collection("patients").snapshots()) {
      for (var message in snapshot.docChanges) {
        print("proVillage ${pro.Village}");
        print("firebase Village ${message.doc.data()!['village']}");
        if(message.doc.data()!['village']==pro.Village) {
          print("village equal patientname ${message.doc.data()!['patient name']}");
          if (message.doc.data()!['patient name'].toString().toLowerCase().replaceAll(" ", "") ==
              patientName.toLowerCase().replaceAll(" ", "")) {
            print("Entered inside loop");
            isPresentAlready = true;
            docId = message.doc.id;
            dateList = message.doc.data()?['list'];
            Tablets = message.doc.data()?['tab_list'] ?? [];
            break;
          } else {
            isPresentAlready = false;
          }
        }
      }
      if (isPresentAlready) {
        setState(() {
          messageAbtPatient = "Patient present Already";
        });
      } else {
        setState(() {
          messageAbtPatient = "";
        });
      }
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    indexValue = 1;
    isPresentAlready1 = false;
    isPresentAlready = false;

    callListWidget = 1;
  }

  @override

  Widget build(BuildContext context) {
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      if (_auth.currentUser != null) {
        print("Entered New Patient page ${pro.Village}");
      } else {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => AdminLogin()));
        Navigator.pop(context);
      }
    }
    return Container(
      color: Colors.blueGrey,

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
         //backgroundColor: Color(0xFF010001),
           child:
    Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
    backgroundColor: Colors.blueGrey,
    title: Text("Patient Detail"),
      actions: [
        (mainIndex==1)?Material(
          borderRadius: BorderRadius.circular(200),
          child: MaterialButton(
            color: Colors.blueGrey,
            onPressed: (){
              setState(() {
                mainIndex = 0;
              });
            },
            child: Text("Done",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 17),),
          ),
        ):Container(),
      ],
    ),body:
    IndexedStack(
            index: mainIndex,
            children: [
              // if(isPresentAlready)
              //       WillPopScope(child: Container(), onWillPop: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPatient())); return Future.value(true);}),

        Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 20),
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              messageAbtPatient,
                              style: TextStyle(color: Colors.red),
                            ),
                            if (isPresentAlready1)
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:0.0),
                                    child: Icon(Icons.note_alt_outlined,size: 30,color: Colors.black,),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:30.0,right: 30,bottom: 30),
                                      child: TextFormField(
                                        controller: nameController,
                                        style: TextStyle(color: Colors.black),
                                        onChanged: (value) {
                                          setState(() {
                                            value = nameController.text;
                                            print(nameController?.text);
                                            patientName = value;
                                            getPatients(patientName);
                                          });
                                        },
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                            labelText: "Enter patient Name",
                                            labelStyle: TextStyle(color: Colors.black),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(200),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(200),
                                                borderSide: BorderSide(
                                                    color: Colors.black, width: 4.0))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (!isPresentAlready1)
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:7.0,right: 3),
                                    child: Icon(Icons.note_alt_outlined,size: 30,color: Colors.black,),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:30.0,bottom:30,right: 30,left: 3),
                                      child: TextInput(
                                          pass: false,
                                          inputText: "Enter patient Name",
                                          onClick: (value) {
                                            patientName = value;
                                            getPatients(patientName);
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            Container(
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 30, top: 10),
                                    height: 100,
                                    width: 100,
                                    child: TextField(
                                      onChanged: (value) {
                                        age = value;
                                      },
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          labelText: "Age",
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 3.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 4.0))),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 30, top: 10),
                                    height: 100,
                                    width: 150,
                                    child: TextField(
                                      onChanged: (value) {
                                        height = value;
                                      },
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          hintText: "Height(cm)",
                                          labelText: "Height(cm)",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 3.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 4.0))),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 30, top: 10),
                                    height: 100,
                                    width: 100,
                                    child: TextField(
                                      onChanged: (value) {
                                        weight = value;
                                      },
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          hintText: "Weight(kg)",
                                          labelText: "Weight(kg)",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 3.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 4.0))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:0.0,top:20,bottom: 20,right:20),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right:13.0),
                                    child: IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.venusMars)),
                                  ),
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white)
                                      ),
                                      child: DropdownButton(
                                          borderRadius: BorderRadius.circular(10),
                                          dropdownColor: Colors.white,
                                          iconEnabledColor: Colors.blue,
                                          focusColor: Colors.black,
                                          style: TextStyle(color:Colors.black,fontWeight: FontWeight.w300,fontSize: 18),
                                          value: SelectedValue??"M",
                                          hint: Text("Sex",  style: TextStyle(color:Colors.red,fontWeight: FontWeight.w300,fontSize: 18),),
                                          items: DropDownList ,
                                          onChanged: (value){
                                            setState((){
                                              print("sex : $value");
                                              SelectedValue = value;
                                              Sex = SelectedValue!;
                                              print("Sex selected: $Sex");});
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),//male

                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child:  Icon(Icons.monitor_heart_outlined,size: 30),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:10.0,top:20,bottom: 20,right: 20),
                                    child: TextField(
                                      onChanged: (value) {
                                        bp = value;
                                      },
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          labelText: "Bp",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 3.0)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 4.0))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                             Row(
                               children: [
                                 IconButton(icon: FaIcon(FontAwesomeIcons.notesMedical),iconSize: 25, onPressed: () {  },),
                                 Expanded(
                                   child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0,right:20,bottom: 20),
                                    child: TextInput(
                                        pass: false,
                                        inputText: "Referral",
                                        onClick: (value) {
                                          p_tion = value;
                                        }),
                            ),
                                 ),
                               ],
                             ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:0.0),
                                  child: IconButton(icon: FaIcon(FontAwesomeIcons.personDotsFromLine),iconSize: 25, onPressed: () {  },),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:20,right:20,bottom: 20),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      onChanged: (value) {
                                        symptoms = value;
                                      },
                                      onTap: () {
                                        setState(() {
                                          indexValue = 1;
                                        });
                                      },
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
                                          hintText: "Diagnosis",
                                          labelText: "Diagnosis",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 3.0)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(200),
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 4.0))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(200),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Icon(Icons.add_circle_outline,size: 30,),
                                        ),
                                        TextButton(
                                          onPressed: (){
                                                    setState(() {
                                                      mainIndex = 1;
                                                    });
                                                  },
                                                  child: Text("Add tablets",style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600,fontSize: 16),),
                                                  ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(30),
                                    child: MaterialButton(
                                      elevation: 30.0,
                                      onPressed: () {
                                        _controllers.clear();
                                        date = DateTime.now();
                                        dateList.add(date.toString());
                                        print("docId $docId");
                                        k_final_list = {
                                          datetime: {
                                            "patient name": patientName.replaceAll(" ", ""),
                                            "symptoms": symptoms,
                                            "prescription": p_tion,
                                            "bp": bp,
                                            "height": height,
                                            "weight": weight,
                                            "tablets": k_Main_tablet_list
                                          }
                                        };
                                        // print("Final List $k_final_list");
                                        if (isPresentAlready1||isPresentAlready) {
                                          print(
                                              'present already update condition $dateList');
                                          print("date ${dateList.last}");
                                          //_firestore.collection("patients").doc(docId).update({"patient name":patientName,"symptoms":symptoms,"prescription":p_tion,"bp":bp,"height":height,"weight":weight,"tablets2":k_final_list,'datetime':FieldValue.serverTimestamp().toString()});
                                          //  _firestore.collection("patients").doc(docId).update({"$date" : {"patient name":patientName,"symptoms":symptoms,"prescription":p_tion,"bp":bp,"height":height,"weight":weight,"tablets": k_Main_tablet_list},"list":dateList});
                                          _firestore
                                              .collection("patients")
                                              .doc(docId)
                                              .set({
                                            date.toString(): {
                                              "patient name": patientName,
                                              "symptoms": symptoms,
                                              "prescription": p_tion,
                                              "bp": bp,
                                              "tablets": k_Main_tablet_list,
                                              "age": age,
                                              "height": height,
                                              "weight": weight,
                                              'datetime': date,
                                              "tab_list": Tablets.toSet().toList(),
                                              "doctor": pro.Doctor,
                                              "nurse": pro.Nurse,
                                              "fieldIncharge": pro.F_Incharge,
                                              "Project": pro.ProjectName,
                                            },
                                            "list": dateList
                                          }, SetOptions(merge: true));
                                        } else if (!isPresentAlready1|| !isPresentAlready) {
                                          print("Not present condition");
                                          _firestore.collection("patients").add({
                                            date.toString(): {
                                              "patient name": patientName,
                                              "symptoms": symptoms,
                                              "prescription": p_tion,
                                              "bp": bp,
                                              "age": age,
                                              "height": height,
                                              "weight": weight,
                                              "tablets": k_Main_tablet_list,
                                              "tablets": k_Main_tablet_list,
                                              "datetime": date,
                                              "tab_list": Tablets.toSet().toList(),
                                              "doctor": pro.Doctor,
                                              "nurse": pro.Nurse,
                                              "fieldIncharge": pro.F_Incharge,
                                              "Project": pro.ProjectName,

                                            },
                                            "list": dateList,
                                            "sex": Sex,
                                            "village": pro.Village,
                                            "patient name": patientName,
                                          });
                                          //    _firestore.collection("patients").add({"patient name":patientName,"symptoms":symptoms,"prescription":p_tion,"bp":bp,"height":height,"weight":weight,"tablets2":k_final_list,'datetime':FieldValue.serverTimestamp().toString()});
                                        }
                                        k_Main_tablet_list = {};
                                        print("Submited all");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PageRouter()));
                                      }
                                      // _firestore.doc("dDoUn2FPuia3FZEFoyV8").collection("patients").add({"patient name":patientName,"symptoms":symptoms,"prescription":p_tion,"bp":bp,"height":height,"weight":weight,"tablets":k_final_list,'datetime':FieldValue.serverTimestamp()});
                                      //
                                      ,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.verified_user,
                                            color: Colors.black,
                                          ),
                                          Text("Submit All",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
                Column(children: [
                  if(mainIndex ==1)
                  WillPopScope(child:Container(), onWillPop: () {
                    setState((){
                      mainIndex =0;
                    });
                    return Future.value(false);
                  },
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller:
                      _scrollController, //The Controller
                      itemCount: callListWidget,
                      itemBuilder: (context, index) {
                        _controllers
                            .add(new TextEditingController());
                        return ListWidget(
                            patientName: patientName,
                            onTap: () {
                              print("changed");
                              setState(() {
                                callListWidget++;
                              });
                            },
                            cc: index);
                      },
                    ),
                  ),
                ]),
            ],
          ),
        ),
      ));
  }
}
class ListWidget extends StatefulWidget {
  String patientName;
  Function() onTap;
  int cc;
  ListWidget(
      {required this.patientName, required this.onTap, required this.cc});
  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  Map tablets_duration = {};
  String l_tablets = "";
  bool value = false;
  bool l_mrng = false;
  bool l_noon = false;
  bool l_evng = false;
  bool l_night = false;
  bool l_bf = false;
  bool l_af = false;
  int _r_value = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: Column(children: [
        //1st row
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,right:20,bottom:10,left: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:0.0),
                  child: IconButton(icon: FaIcon(FontAwesomeIcons.pills),iconSize: 30, onPressed: () {  },),
                ),
                Expanded(
                  child: TextField(
                    controller: _controllers[widget.cc],
                    onChanged: (value) {
                      setState(() {
                        print("CC ${widget.cc}");
                        indexValue = 0;
                        filterTablet = _controllers[widget.cc]
                            .text
                            .replaceAll(" ", "");
                        l_tablets = filterTablet;
                        print("l_tab $l_tablets");
                        // Tablets.add(value);
                         });
                    },
                    onEditingComplete: () {
                      setState(() {
                        indexValue = 1;
                      });
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: "Tablet Name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(200),
                          borderSide: BorderSide(color: Colors.black,width: 3)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(200),
                          borderSide: BorderSide(color: Colors.black,width: 4)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: IndexedStack(
              index: indexValue,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 100,
                    child: Scrollbar(
                      controller: _controller,
                      isAlwaysShown: true,
                      showTrackOnHover: true,
                      child: ListView.builder(
                        controller: _controller,
                          itemCount: groupOfTablets.length,
                          itemBuilder: (context, index) {
                            return (filterTablet == null ||
                                filterTablet == "")
                                ? Container()
                                : groupOfTablets[index]
                                .replaceAll(' ', '')
                                .toLowerCase()
                                .contains(
                                filterTablet.toLowerCase())
                                ? Column(
                              children: [
                                TextButton(
                                  child: Text(
                                    groupOfTablets[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontStyle:
                                        FontStyle.italic,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    flag = true;
                                    setState(() {
                                      _controllers[widget.cc]
                                          .text =
                                      groupOfTablets[index];
                                      l_tablets = _controllers[widget.cc].text;
                                      print("inside cardText  $l_tablets");
                                      indexValue = 1;
                                    });
                                  },
                                ),
                                Container(
                                  width: 150,
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            )
                                : Container();
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:25.0,left:15,right:15,bottom: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Before Food",
                        style: TextStyle(color: Colors.black),
                      ),
                      Radio(
                          activeColor: Colors.black,
                          value: 1,
                          groupValue: _r_value,
                          onChanged: (value) {
                            setState(() {
                              _r_value = value!;
                              if (_r_value == value) {
                                l_bf = true;
                                l_af = false;
                                print("Before food pressed");
                              } else {
                                l_bf = false;
                                l_af = true;
                                print("not Before food not pressed");
                              }
                            });
                          }),
                      Text(
                        "After Food",
                        style: TextStyle(color: Colors.black),
                      ),
                      Radio(
                          activeColor: Colors.black,
                          value: 2,
                          groupValue: _r_value,
                          onChanged: (value) {
                            setState(() {
                              _r_value = value!;
                              if (_r_value == 2) {
                                l_af = true;
                                l_bf = false;
                                print("after food pressed");
                              } else {
                                print("Not after food pressed");
                                l_af = false;
                                l_bf = true;
                              }
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
        //1st row's 2nd column
        Column(children: [
          //1st's side row 1
          // Row(children: [SizedBox(height: 30)])
        ]),

        //2nd Row
        Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(children: [
              Column(
                children: [
                  Text("Mrng", style: TextStyle(color: Colors.black)),
                  Checkbox(
                      checkColor: Colors.red,
                      activeColor: Colors.black,
                      value: l_mrng,
                      onChanged: (value) {
                        setState(() {
                          indexValue = 1;
                          Mrng = value!;
                          l_mrng = value;
                          print("Check box mrng $value");
                        });
                      }),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Noon",
                    style: TextStyle(color: Colors.black),
                  ),
                  Checkbox(
                      checkColor: Colors.red,
                      activeColor: Colors.black,
                      value: l_noon,
                      onChanged: (value) {
                        setState(() {
                          indexValue = 1;
                          setState(() {
                            Noon = value!;
                            l_noon = value;
                            print("Check box Noon $value");
                          });
                        });
                      }),
                ],
              ),
              Column(
                children: [
                  Text("Evng", style: TextStyle(color: Colors.black)),
                  Checkbox(
                      checkColor: Colors.red,
                      activeColor: Colors.black,
                      value: l_evng,
                      onChanged: (value) {
                        setState(() {
                          Evng = value!;
                          indexValue = 1;
                          l_evng = value;
                          print("Check box evng $value");
                        });
                      })
                ],
              ),
              Column(
                children: [
                  Text("Night", style: TextStyle(color: Colors.black)),
                  Checkbox(
                      checkColor: Colors.red,
                      activeColor: Colors.black,
                      value: l_night,
                      onChanged: (value) {
                        setState(() {
                          Night = value!;
                          indexValue = 1;
                          l_night = value;
                          print("Check box night $value");
                        });
                      }),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                child: Column(
                  children: [
                    Text(
                      "submit",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.gre
                    )
                  ],
                ),
                onPressed: () {
                  widget.onTap();
                  Tablets.add(l_tablets);
                  print("tablet list ${Tablets}");
                  count++;
                  tablets_duration.addAll({
                    l_tablets: {
                      "Bf": l_bf,
                      "Af": l_af,
                      "Mrng": l_mrng,
                      "Noon": l_noon,
                      "Evng": l_evng,
                      "Night": l_night
                    }
                  });
                  k_Main_tablet_list.addAll(tablets_duration);
                  print(tablets_duration);
                  print("k_maiin_tablet+list ${k_Main_tablet_list}");
                  setState(() {});
                },
              )
            ]),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top:19),
          width: MediaQuery.of(context).size.width - 200,
          child: Divider(
            color: Colors.black,
            thickness: 2,
            height: 10,
          ),
        )
      ]),
    );
  }
}

// Column(
// children: [
// Column(
// children: [
// Row(
// children: [
// ],
// ),
// ],//////////////////
// ),
// Column(
// children: [
// Row(
// children: [
//
// });}),
//
//
// ],
// )
// ],
// ),
// /////////////
// Row(
// children: [
// ],
// )
// ],
// );
/////////////////////////////////////////////////Text Input Decoration
// InputDecoration(
// // labelText: "Weight",
// hintStyle: TextStyle(
// color: Colors.white, fontSize: 14),
// hintText: "Weight(kg)",
// // labelText: "BP",
// enabledBorder: UnderlineInputBorder(
// borderSide:
// BorderSide(color: Colors.white))),
//
// //
