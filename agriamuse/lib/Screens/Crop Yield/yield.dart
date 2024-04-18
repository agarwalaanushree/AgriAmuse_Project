import 'package:agriamuse/Screens/Crop%20Yield/result.dart';
import 'package:agriamuse/models/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Yield extends StatefulWidget {
  @override
  _YieldState createState() => _YieldState();
}

class _YieldState extends State<Yield> {
  GlobalKey<FormState> _key = new GlobalKey();
  late double ahumid = 0.0,
      atemp = 0.0,
      rainfall = 0.0,
      sph = 0.0,
      shumid = 0.0;

  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    // User initialization code here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('Crop Prediction')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(AppLocalizations.of(context)
                    .translate("Let's Predict Your Crop")),
              ),
              SizedBox(height: 5.0),
              Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: FormUI(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context).translate('Air Humidity')),
          maxLength: 32,
          validator: validateInput,
          onSaved: (String? val) {
            ahumid = double.parse(val!);
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context).translate('Air Temperature')),
          maxLength: 32,
          validator: validateInput,
          onSaved: (String? val) {
            atemp = double.parse(val!);
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context).translate('Rainfall')),
          maxLength: 32,
          validator: validateInput,
          onSaved: (String? val) {
            rainfall = double.parse(val!);
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context).translate('Soil Humidity')),
          maxLength: 32,
          validator: validateInput,
          onSaved: (String? val) {
            shumid = double.parse(val!);
          },
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context).translate('Soil pH')),
          maxLength: 32,
          validator: validateInput,
          onSaved: (String? val) {
            sph = double.parse(val!);
          },
        ),
        SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: _sendToServer,
          child: Text(AppLocalizations.of(context).translate('Send')),
        ),
      ],
    );
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).translate('Please enter a value');
    }
    return null;
  }

  Future<void> createData() async {
    await databaseReference.child("Realtime").update({
      'Air Humidity': ahumid,
      'Air Temp': atemp,
      'Rainfall': rainfall,
      'Soil Humidity': shumid,
      'Soil pH': sph,
    });
  }

  _sendToServer() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      await createData();
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Result()),
      );
    }
  }
}
