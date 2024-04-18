import 'dart:async';
import 'package:agriamuse/models/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final databaseReference = FirebaseDatabase.instance.reference();
  double ahumid = 0.0, atemp = 0.0, rainfall = 0.0, sph = 0.0, shumid = 0.0;
  String? crop;

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Your Result")),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Center(
          child: Card(
            child: Column(
              children: [
                crop != null
                    ? Center(
                        child: Text(AppLocalizations.of(context)
                            .translate("Predicted Crop : $crop")))
                    : Center(
                        child: Text(AppLocalizations.of(context)
                            .translate("Loading....."))),
                crop != null
                    ? Image(image: AssetImage("assets/mango.jpg"))
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void readData() async {
    await databaseReference
        .child("Realtime")
        .once()
        .then((DataSnapshot snapshot) {
          Map<dynamic, dynamic>? values = snapshot.value as Map?;
          if (values != null) {
            setState(() {
              ahumid = values['Air Humidity'];
              atemp = values['Air Temp'];
              rainfall = values['Rainfall'];
              shumid = values['Soil Humidity'];
              sph = values['Soil pH'];
            });
          }
        } as FutureOr Function(DatabaseEvent value));

    await databaseReference
        .child("croppredicted")
        .once()
        .then((DataSnapshot snapshot) {
          Map<dynamic, dynamic>? values = snapshot.value as Map?;
          if (values != null) {
            setState(() {
              crop = values['crop'];
            });
          }
          print(crop);
        } as FutureOr Function(DatabaseEvent value));
  }
}
