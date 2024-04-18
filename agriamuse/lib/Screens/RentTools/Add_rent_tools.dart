import 'dart:io';
import 'package:agriamuse/models/app_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final _db = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class AddTool extends StatefulWidget {
  const AddTool({Key? key}) : super(key: key);

  @override
  State<AddTool> createState() => _AddToolState();
}

class _AddToolState extends State<AddTool> {
  var categories = ['Tractors', 'Harvestors', 'Pesticides', 'Others'];
  String? categoryValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController contactinfoController = TextEditingController();
  File? pic;

  void saveUser() async {
    String name = nameController.text.trim();
    String cost = costController.text.trim();
    String desc = descController.text.trim();
    String contactinfo = contactinfoController.text.trim();

    nameController.clear();
    costController.clear();
    descController.clear();
    contactinfoController.clear();

    if (name.isNotEmpty &&
        cost.isNotEmpty &&
        categoryValue != null &&
        desc.isNotEmpty) {
      if (pic != null) {
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child("pic")
            .child(Uuid().v1())
            .putFile(pic!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadurl = await taskSnapshot.ref.getDownloadURL();

        Map<String, dynamic> toolData = {
          "name": name,
          "cost": cost,
          "category": categoryValue!,
          "desc": desc,
          "pic": downloadurl,
          "contactinfo": contactinfo,
        };

        FirebaseFirestore.instance.collection("addtools").add(toolData);
        print("Tools Added");
      } else {
        print("Please select an image");
      }
    } else {
      print("Please fill all fields");
    }

    setState(() {
      pic = null;
    });
  }

  void _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(
          context, '/login'); // Navigate to login screen
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate('Add Tools')),
        backgroundColor: Color.fromARGB(240, 70, 235, 123),
        elevation: 0, // Remove appbar elevation
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () async {
                XFile? selectedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (selectedImage != null) {
                  setState(() {
                    pic = File(selectedImage.path);
                  });
                  print("Image selected");
                } else {
                  print("No image selected");
                }
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: pic != null
                      ? Image.file(
                          pic!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Icon(
                          Icons.add_a_photo,
                          size: 60,
                          color: Colors.grey,
                        ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate("Name"),
                hintText:
                    AppLocalizations.of(context).translate("Enter tool name"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: costController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate("Cost per Day"),
                hintText: AppLocalizations.of(context).translate("Enter cost"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: categoryValue,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  categoryValue = value;
                });
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate("Category"),
                hintText:
                    AppLocalizations.of(context).translate("Select a category"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate("Description"),
                hintText:
                    AppLocalizations.of(context).translate("Enter description"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: contactinfoController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate("Contact Number"),
                hintText: AppLocalizations.of(context)
                    .translate("Enter contact number"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveUser,
              child: Text(AppLocalizations.of(context).translate("Add")),
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
