import 'dart:io';
import 'package:agriamuse/models/app_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddCrops extends StatefulWidget {
  const AddCrops({Key? key}) : super(key: key);

  @override
  State<AddCrops> createState() => _AddCropsState();
}

class _AddCropsState extends State<AddCrops> {
  final TextEditingController cropnameController = TextEditingController();
  final TextEditingController mspController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descrController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  File? pic;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pic = File(pickedFile.path);
      });
    }
  }

  void _saveUser() async {
    if (pic == null) {
      return;
    }

    String cropname = cropnameController.text.trim();
    String msp = mspController.text.trim();
    String quantity = quantityController.text.trim();
    String descr = descrController.text.trim();
    String contact = contactController.text.trim();

    cropnameController.clear();
    mspController.clear();
    quantityController.clear();
    descrController.clear();
    contactController.clear();

    final String imageId = Uuid().v1();
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('crops/$imageId.jpg');
    await storageRef.putFile(pic!);
    final String imageUrl = await storageRef.getDownloadURL();

    Map<String, dynamic> cropData = {
      'cropname': cropname,
      'msp': msp,
      'quantity': quantity,
      'descr': descr,
      'pic': imageUrl,
      'contact': contact,
    };

    FirebaseFirestore.instance.collection('smartconnect').add(cropData);
    print('Crop Added');
    setState(() {
      pic = null;
    });
  }

  Future<void> _logout() async {
    await _auth.signOut(); // Sign out the user
    Navigator.of(context).popUntil(
        (route) => route.isFirst); // Navigate back to the first screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate('Add Crops')),
        backgroundColor: Color.fromARGB(240, 70, 235, 123),
        elevation: 0, // Remove appbar elevation
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout), // Add logout button icon
            onPressed: _logout, // Call _logout method when tapped
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text(pic == null
                  ? AppLocalizations.of(context).translate('Choose Image')
                  : AppLocalizations.of(context).translate('Change Image')),
            ),
            if (pic != null)
              SizedBox(
                height: 200,
                child: Image.file(
                  pic!,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            TextFormField(
              controller: cropnameController,
              decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('Crop Name')),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: mspController,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)
                      .translate('Minimum Support Price')),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('Quantity')),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: descrController,
              decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('Description')),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: contactController,
              decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('Contact Number')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUser,
              child: Text(AppLocalizations.of(context).translate('Add Crop')),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(240, 70, 235, 123),
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
