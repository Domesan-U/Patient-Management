import 'package:flutter/material.dart';
import 'package:patients/Page_router.dart';
import 'package:patients/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patients/ProjectList.dart' as pro;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'newpatient.dart';
import 'fetch_records.dart';
import 'notFoundPage.dart';
List SearchList = [];
bool pageDecider = false;
List SearchList1 = [];
String filter = "";
bool flag = true;
final messageTextController = TextEditingController();
final _firestore = FirebaseFirestore.instance;
void getPatientList() async {
  print("Reached inside getPatientList in Search_Patient Module");
  await for (var snapshot in _firestore
      .collection('patients')
      .snapshots()) {
    for (var message in snapshot.docChanges) {
      if(pro.Village == message.doc.data()!['village']) {
        print("Found in the village${message.doc.data()!['village']} patient name: ${message.doc.data()!["patient name"]}");
        SearchList1.add(message.doc.data()!["patient name"]);
        print("SearchList $SearchList");
        SearchList = SearchList1.toSet().toList();
      }
    }
  }
 }
class SearchPatient extends StatefulWidget {
  const SearchPatient({Key? key}) : super(key: key);
  @override
  State<SearchPatient> createState() => _SearchPatientState();
}
class _SearchPatientState extends State<SearchPatient> {
  @override
  void deactivate() {
    //TODO: implement deactivate
    super.deactivate();
    SearchList = [];
    SearchList1 = [];
    print("Deactivated search");
  }
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    SearchList=[];
    SearchList1=[];
    print("list: $SearchList, List2: $SearchList1");
    print("Reached search Patient init");
    messageTextController.addListener(() {
      setState(() {
          filter = messageTextController.text.replaceAll(' ', '');
          print("filter $filter");
         });
    });
    getPatientList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF17161D),
        body: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 20, right: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WillPopScope(child: Container(), onWillPop: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>PageRouter())); return Future.value(true);}),
                SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Container(
                      width: 250,
                      child: TextField(
                        style: TextStyle(color: Colors.white70),
                        cursorColor: Colors.white70,
                        controller: messageTextController,
                        decoration: InputDecoration(
                          labelText: "Search",
                          labelStyle: TextStyle(color: Colors.white70),
                          hintText: "Search patient",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: BorderSide(
                              color: Colors.white70,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: BorderSide(
                              color: Colors.white70,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          getPatientList();
                        },
                      ),
                    ),
                    GestureDetector(
                      child: MaterialButton(
                        child: Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          nextPage()?
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => fetchRecords(patientName))):
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>NotFound() ));

                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right:30.0),
                      child: ListView.builder(
                          itemCount: SearchList.length,
                          itemBuilder: (context, index) {
                            return filter == null || filter == ""
                                ? Container()
                                :SearchList[index].replaceAll(' ','')
                                        .toLowerCase()
                                        .contains(filter.toLowerCase())
                                    ? Padding(
                                      padding: const EdgeInsets.only(right: 38.0),
                                      child: Card(
                                          color: Color(0xFF17161D),
                                          child: Column(
                                            children: [
                                              TextButton(
                                                child: Text(
                                                  SearchList[index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontStyle: FontStyle.italic,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  flag = true;
                                                  setState(() {
                                                    messageTextController.text =
                                                        SearchList[index];
                                                  });
                                                },
                                              ),
                                              Container(
                                                width: 150,
                                                child: Divider(
                                                  color: Colors.white70,
                                                ),
                                              )
                                            ],
                                          )),
                                    )
                                    : Container();
                          }),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          elevation: 300,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(300),
                          child: MaterialButton(
                            child: Text(
                              "New Patient",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => newpatient(p_name:"",id:"",CdateList:[],tabList:[])));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Material(
                            elevation: 300,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(300),
                            child: MaterialButton(
                              child: Text(
                                "  Continue  ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                    fontStyle: FontStyle.italic),
                              ),
                              onPressed: () {
                                nextPage()?
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => fetchRecords(patientName))):
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>NotFound() ));
                                    },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
          ),
        ));
  }
}
bool nextPage(){
  bool returnValue = false;
  print("Icon pressed");
  print("SearchList $SearchList1");
  patientName = messageTextController.text;
  for(var names in SearchList ){
    print("$names names in loops");
    if(patientName == names){
      print("found $names");
      pageDecider = true;
      return true;
    }
  }
  return false;
}
