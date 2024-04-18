import 'package:agriamuse/models/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agriamuse/models/crop_model.dart';
import 'package:agriamuse/Screens/SmartConnect/Crop_details.dart';
import 'package:agriamuse/Screens/SmartConnect/Add_crops.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<List<crop>> allCrops() async {
  final snapshot = await _db.collection("smartconnect").get();
  final allData = snapshot.docs.map((e) => crop.fromSnapshot(e)).toList();
  return allData;
}

class Crops extends StatelessWidget {
  const Crops({super.key});

  final Color primaryColor = const Color(0xFF66BB6A);
  final Color bgColor = const Color(0xffF9E0E3);
  final Color secondaryColor = const Color(0xff324558);

  void _logout(BuildContext context) async {
    await _auth.signOut(); // Sign out the user
    Navigator.pushReplacementNamed(
        context, 'welcome'); // Navigate to login screen
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Theme(
        data: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            color: Color.fromARGB(241, 45, 235, 106),
            iconTheme: IconThemeData(color: secondaryColor),
            actionsIconTheme: IconThemeData(
              color: secondaryColor,
            ),
            toolbarTextStyle: TextTheme(
              titleLarge: TextStyle(
                color: secondaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ).bodyMedium,
            titleTextStyle: TextTheme(
              titleLarge: TextStyle(
                color: secondaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ).titleLarge,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppLocalizations.of(context).translate('Crops')),
            leading: const Icon(FontAwesomeIcons.tree),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout), // Add logout icon
                onPressed: () => _logout(context), // Call _logout method
              ),
            ],
            /* bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: primaryColor,
              unselectedLabelColor: secondaryColor,
              tabs: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(""),
                ),
              ],
            ), */
          ),
          body: TabBarView(
            children: <Widget>[
              FutureBuilder<List<crop>>(
                future: allCrops(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<crop> cropList = snapshot.data!;
                      return GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: cropList.length,
                        itemBuilder: (context, index) {
                          return _buildArticleItem(context, cropList[index]);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(AppLocalizations.of(context)
                            .translate(snapshot.error.toString())),
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCrops()),
              );
            },
            backgroundColor: Color.fromARGB(240, 70, 235, 123),
            hoverColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, crop crop) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CropDetails(cropData: crop),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                crop.pic,
                width: double.infinity,
                height: 97.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate(crop.cropname),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    AppLocalizations.of(context).translate("MSP: ") +
                        ("Rs. ") +
                        AppLocalizations.of(context)
                            .translate(crop.msp.toString()) +
                        ("/Quintal"),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    AppLocalizations.of(context).translate("Quantity: ") +
                        AppLocalizations.of(context)
                            .translate(crop.quantity.toString()) +
                        (" Quintals"),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
