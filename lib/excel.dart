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
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "patient-7bd49",
  "private_key_id": "425c0481bc75a86322d3f86d63d6d759b319e056",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDaV9EAI8WNvW0t\nw/ZPxVqWrXP1VP9bO3in5vwTNQoMdQA/0CVJEE4n2NY3ImBsHRqW2xYa+TZo042N\n/PGp8Ue/nGB+GaT0K/D4F2zHTf60sTMY5De8dqSDMvjMMwwzFKXVeC2BvOZXiidl\nbN2XIoRJLW13lTJjs5eoEGMPHmmxjK30pw3hOhu5p3LBwlx8WfOEw9ZMNB8Wx399\nSHckhUVMzStlEfSDU8vMDFlLY6F47GZcZPMXYTvU6GJfWSkK6ZbCN+IXbt6+w/wL\n+gvoiScvQC4lmzax3y8KClrgmq82OqZsqcEe9azE7+fCNJCHvUmYZxbIF355Z5Ol\n49xIYwSpAgMBAAECggEACuGJdtpRhAjGohs78SnCo/Os7bL4rtE96BAoy8Q+5fQG\nuSdkVEnNu0qhEkpSR9EDfDUa2ulEfuDcExFh8bgmfTQL0vzwLYLrFVIFh8EpSlPy\nWfE1ndzDwg4OPA7nMrx6rzK4AdkqGX63C+Tq/hcoRIVRCT6ULkfK7QM0DJLVbZWf\nnK6Q80x8X1uJ3/mRYHGNvFOWKM42TgP3n7ol3y8aK1Mewe26lO413HECLqVMhY1L\ncq9LBc547y+5nk0M5o81H9pgJkDoFOvEHZ7R3xoArciHQON1avYmQrnBaGUZwj/y\nTEkSVvJ+VxELxHgrqwiM9UEprSTn+xBZZ21ewFtDqQKBgQDvg4wqRnl4YExI+5pn\np9tZgBe8gqUpqHAIPDgI2Elg4fOSlIvBL/N0GI9/F/l9UDizAzfTPS24Ln14OvyY\n1DFK3aSedMqVhGzw2H1YYSpf+G5mEvEXkHq6/sfIFiSyh8qjSzs2oNnj+2SgUe/s\nAAiAUCimOaHim1ssXkWmkoflHwKBgQDpXzg7t8xr3ayV0w374jeSgLpUEuVoKpjd\npZHLeDWD+O+x0KSSvrMNp/m/G3hQxVOGM36CX1Xx4kA2A9vDgc18GAiuqFv9hena\nVoeO2f8CzWCr5o6p1gWDfsu72hkDKOU7E//QkNrwU7QhObfa/ZPdrVlUoMFlUJ55\nKy68FLLVNwKBgF6iFTFm4vui4ME9WAZ4lfxI1hgPbn6FJK68TE+CVYvH+tsBgi50\nabaHNbs7l8HhfmWMcfQuie/pvn1QoRkpTciMxkwtTRXCWuDWSMAws/NzTvtZpJRw\n620S2ZC+3wUDDhdy1BSDfVPMsjd96FPQt4srIMR8pO/J/j4LiW2FG9h1AoGBAIft\najd+SpbZOtjZYV/A11WBnQWzK+OMTBVthonYrnL738DWIcVHRctCd3kUavPAu3GD\nNMCC/vAwM+5CORKa3DDXXtc8QLhd82O02qgd2SassQ3u8FGD0xpQFCKKWd85Rqsu\nbuXwOVWZq2Ve1PO8lw+bFFjyeTKlzmgM+t+Zvr/pAoGAZja2AZTfD7zBunkKmSkS\npYcPX5I+YrulHMd0PyW3UR+mwpr7drVQUqmcSaeByAyyd6c2QNJKpdC8ofsOlfrf\nTmOEcatjLJ1fFkB3CgJi6M8O/8dacLdgod5bxpYdLdYWj8Lu9rWVQAv1kWXjyJKG\n/g/OmaqalMRmDm4dRPsw3Uk=\n-----END PRIVATE KEY-----\n",
  "client_email": "patient-record@patient-7bd49.iam.gserviceaccount.com",
  "client_id": "104636226205138931853",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/patient-record%40patient-7bd49.iam.gserviceaccount.com"
}
''';
const _spreadSheetId = "1PV3Ls3AQzZI6LDlyVdJ9xUiNZwhm8IDaIEswMLh-PJY";
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
              uri: Uri.parse('https://docs.google.com/spreadsheets/d/1PV3Ls3AQzZI6LDlyVdJ9xUiNZwhm8IDaIEswMLh-PJY/edit#gid=1303503874'),
              builder: (context,followLink)=>ElevatedButton(onPressed: followLink, child: Text("Navigate to Sheets"))
            ),
          )
        ),
      ),
    );
  }
}

