import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patients/newpatient.dart';
//import 'package:excel/excel.dart';
import 'excel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row,Column,Border;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'excel.dart';
final _firestore = FirebaseFirestore.instance;

List numberToMonth = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

class fetchRecords extends StatefulWidget {
  fetchRecords(this.patientName) {
    print("The patient name we got $patientName");
  }
  String patientName = "";
  @override
  State<fetchRecords> createState() => _fetchRecordsState();
}

String ref = "";
String symptoms = "";
String bp = "";
String height="";
String weight = "";
String age = "";
Map tablets = {};
List Tablets = [];
String docId = "";
List lister1 = ['pa','ro'];
Timestamp? t;
var maper;
List dateList = [];
// automatically creates 1 empty sheet: Sheet1
void _exportToExcel()async{
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
for(int i=0; i<3; i++) {
  var j = i;
  Range range = sheet.getRangeByIndex(1, i=0);
 range.setText("Symptoms");
 sheet.insertRow(1,1,ExcelInsertOptions.formatAsAfter);
  //sheet.importList(lister1, 3, sheet., false);
}

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

 }
int count = 0;
DateTime? date;
Map<String, dynamic>? krequiredMessage;

class _fetchRecordsState extends State<fetchRecords> {
  bool flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPatientDetails();
  }

  void getPatientDetails() async {
    await for (var snapshot in _firestore.collection("patients").snapshots()) {
      for (var message in snapshot.docChanges) {
        if (message.doc.data()!["patient name"] == patientName) {
          patientName = message.doc.data()!['patient name'];
          flag = true;
          setState(() {
            docId = message.doc.id;
            krequiredMessage = message.doc.data();
          });

          // print("Yes Exactly found, Be happy");
          t = message.doc.data()?["datetime"];
          date = t?.toDate();
          symptoms = message.doc.data()?["symptoms"]??"";
           dateList = message.doc.data()?["list"]??[];
           Tablets = message.doc.data()?["tab_list"]??[];
          break;
        }
        else {
          flag = false;
        }
      }
    }
  }
  var p2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Patient Record",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
            ),
            Column(
              children: [
                Material(
                  elevation: 20.0,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black87,
                  child: MaterialButton(
                      minWidth: 20,
                      onPressed: () {
                        getPatientDetails();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => newpatient(
                                    p_name:patientName, id:docId, CdateList:dateList, tabList:Tablets)));
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      )),
                ),

              ],
            ),

          ],
        ),
      ),
      for (int i = 0; i < dateList.length; i++)
        Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text("count $i"),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Previously Visited:  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(
                          "${krequiredMessage![dateList[i]]['datetime'].toDate().day} ${numberToMonth[krequiredMessage![dateList[i]]['datetime'].toDate().month]} ${krequiredMessage![dateList[i]]['datetime'].toDate().year}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Patient Name: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text("$patientName")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("BP:  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text("${krequiredMessage![dateList[i]]['bp']}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Age: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text("${krequiredMessage![dateList[i]]['age']}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Sex ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(" ${krequiredMessage!['sex']}")
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Height: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text("${krequiredMessage![dateList[i]]['height']}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Weight: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(" ${krequiredMessage![dateList[i]]['weight']}")
                    ],
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Project Name: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(" ${krequiredMessage![dateList[i]]['Project']}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Village: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(" ${krequiredMessage!['village']}")
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Doctor: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(" ${krequiredMessage![dateList[i]]['doctor']}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Attended Nurse: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(" ${krequiredMessage![dateList[i]]['nurse']}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Field Incharge: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Text(" ${krequiredMessage![dateList[i]]['fieldIncharge']}")
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Symptoms: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      Expanded(child: Text("${krequiredMessage![dateList[i]]['symptoms']}")),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Referalls: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                     Expanded(child: Text("${krequiredMessage![dateList[i]]['prescription']}"))
                    ],
                  ),
                ),
                Text(
                  "Tablets Prescribed",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                for (var pills in krequiredMessage![dateList[i]]['tab_list'])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$pills",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (krequiredMessage?[dateList[i]]['tablets']
                                  [pills]['Af'])
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(" After Food - "),
                                ),
                              if (krequiredMessage![dateList[i]]['tablets']
                                  [pills]['Bf'])
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Before Food - "),
                                ),
                              if (krequiredMessage![dateList[i]]['tablets']
                                  [pills]['Mrng'])
                                Text("Morning, "),
                              if (krequiredMessage![dateList[i]]['tablets']
                                  [pills]['Noon'])
                                Text("AfterNoon, "),
                              if (krequiredMessage![dateList[i]]['tablets']
                                  [pills]['Evng'])
                                Text("Evening, "),
                              if (krequiredMessage![dateList[i]]['tablets']
                                  [pills]['Night'])
                                Text("Night"),
                            ],
                          ),

                          //   krequiredMessage![dateList[i]]['tablets'][Tablets[j]]['Af']]? Text("${Tablets[0]} After Food: ${Tablets[j]}"): Text("${Tablets[0]} Before Food: ${Tablets[j]}"),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top:35.0),
                  child: Container(
                    width: 200,
                    child: Divider(
                      thickness: 1,
                      height: 2,
                      color: Colors.black87,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    ])
        ////////
        );
  }
}
//ListView.builder(
//             itemCount: 1,
//             itemBuilder: (context, index) {
//               count = dateList.length;
//               print("Count HEre ${dateList.length}");
//               print("here ${getWidget(0)}");
//               return

/////////////////
// bp = message.doc.data()!["bp"].toString();
// height = message.doc.data()!["height"];
// dateList = message.doc.data()!["list"];
// weight = message.doc.data()!["weight"];
// age = message.doc.data()!["age"];
// tablets = message.doc.data()!["tablets"] ?? {};
// symptoms = message.doc.data()!["symptoms"] ?? '';
// ref = message.doc.data()?["prescription"] ?? '' ;
// t = message.doc.data()?["datetime"];
// print("DateTime $t");
// date = t!.toDate();
// print("Symptoms $symptoms");
