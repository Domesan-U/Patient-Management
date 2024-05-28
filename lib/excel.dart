import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patients/newpatient.dart';
import 'package:excel/excel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row,Column,Border;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:url_launcher/link.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:gsheets/gsheets.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'constants.dart';
final _firestore = FirebaseFirestore.instance;
List dateList = [];
List tabletList = [];
var k =-1;
List list =[];


void ExcelCreater() async {
  var k=0;
  final gsheets = GSheets(_credentials);
  List lister = ["Date","Village","Project","patient name","Diagnosis","Referrals","sex","height","weight","bp","age","Doctor","Nurse","FieldIncharge","tablets"];
  final ss = await gsheets.spreadsheet(_spreadSheetId);
  var sheet = ss.worksheetByTitle('patient-record');
  await sheet?.clear();
  await sheet!.values.appendRow(lister);
    await for (var snapshot in _firestore.collection("patients").snapshots()) {
      k=k+1;
      for (var message in snapshot.docChanges) {
        var tabletsList = message.doc.data()!['list'];
        print("tablet list $tabletsList");
        for(int i=0; i<tabletsList.length;i++) {
          list = [tabletsList[i],message.doc.data()?['village'],message.doc.data()?[tabletsList[i]]['Project'],message.doc.data()?[tabletsList[i]]['patient name'],message.doc.data()?[tabletsList[i]]['symptoms'],message.doc.data()?[tabletsList[i]]['prescription'],message.doc.data()?['sex'],message.doc.data()?[tabletsList[i]]['height'],message.doc.data()?[tabletsList[i]]['weight'],message.doc.data()?[tabletsList[i]]['bp'],message.doc.data()?[tabletsList[i]]['age'],message.doc.data()?[tabletsList[i]]['doctor'],message.doc.data()?[tabletsList[i]]['nurse'],message.doc.data()?[tabletsList[i]]['fieldIncharge'],for(int z=0; z<message.doc.data()?[tabletsList[i]]['tab_list'].length;z++) message.doc.data()?[tabletsList[i]]['tab_list'][z]];
          await sheet!.values.appendRow(list);
          print("List $list");
        }
        }

      }

      }

class Excel extends StatelessWidget {
  const Excel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
            child: Link(
              target: LinkTarget.blank,
             //uri: Uri.parse("https://www.youtube.com"),
              uri: Uri.parse('https://docs.google.com/spreadsheets/d/${spreadSheetId}/edit#gid=1303503874'),
              builder: (context,followLink)=>ElevatedButton(onPressed: followLink, child: Text("Navigate to Sheets"))
            ),
          )
        ),
      ),
    );
  }
}

