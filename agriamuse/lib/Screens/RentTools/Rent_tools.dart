import 'package:agriamuse/Screens/Welcome/welcome_screen.dart';
import 'package:agriamuse/models/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:agriamuse/models/rent_tools_model.dart';
import 'package:agriamuse/Screens/RentTools/Details.dart';
import 'package:agriamuse/Screens/RentTools/Add_rent_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
Future<List<Rent>> allRent({String? category}) async {
  QuerySnapshot snapshot;
  if (category != null) {
    snapshot = await _db
        .collection("addtools")
        .where('category', isEqualTo: category)
        .get();
  } else {
    snapshot = await _db.collection("addtools").get();
  }
  final allData = snapshot.docs
      .map(
          (e) => Rent.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>))
      .toList();
  return allData;
}

class RentTools extends StatefulWidget {
  const RentTools({Key? key}) : super(key: key);

  @override
  _RentToolsState createState() => _RentToolsState();
}

class _RentToolsState extends State<RentTools> {
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = "All";
  }

  final Color primaryColor = const Color(0xFF66BB6A);
  final Color bgColor = const Color(0xffF9E0E3);
  final Color secondaryColor = const Color(0xff324558);

  void _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WelcomeScreen()), // Replace LoginScreen with your login screen
      );
    } catch (e) {
      print('Error signing out: $e');
    }
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
            title: Text(AppLocalizations.of(context).translate('Rent Tools')),
            leading: const Icon(FontAwesomeIcons.tools),
            actions: <Widget>[
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: <String>[
                  AppLocalizations.of(context).translate('All'),
                  AppLocalizations.of(context).translate('Machine'),
                  AppLocalizations.of(context).translate('Tractors'),
                  AppLocalizations.of(context).translate('Harvestor')
                ]
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(AppLocalizations.of(context).translate(value)),
                      ),
                    )
                    .toList(),
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => _signOut(context),
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              FutureBuilder<List<Rent>>(
                future: allRent(
                    category:
                        _selectedCategory == 'All' ? null : _selectedCategory),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<Rent> rentList = snapshot.data!;
                      return GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: rentList.length,
                        itemBuilder: (context, index) {
                          return _buildArticleItem(context, rentList[index]);
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
                MaterialPageRoute(builder: (context) => AddTool()),
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

  Widget _buildArticleItem(BuildContext context, Rent rent) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(rentTools: rent),
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
                rent.pic,
                width: double.infinity,
                height: 112.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    rent.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    ("Rs. ") +
                        AppLocalizations.of(context)
                            .translate(rent.cost.toString()) +
                        AppLocalizations.of(context).translate("/day"),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
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
