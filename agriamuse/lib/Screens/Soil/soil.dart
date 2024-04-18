import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'soil_card.dart';

class SoilList extends StatefulWidget {
  const SoilList({Key? key}) : super(key: key);

  @override
  _SoilListState createState() => _SoilListState();
}

class _SoilListState extends State<SoilList> {
  List<Soil> soils = [
    Soil(
        title: 'Alluvial Soil',
        image: Image.asset(
          'assets/images/alluvial.png',
          fit: BoxFit.fill,
        ),
        index: 0),
    Soil(
        title: 'Black Soil',
        image: Image.asset(
          'assets/images/black.jpg',
          fit: BoxFit.fill,
        ),
        index: 1),
    Soil(
        title: 'Red and Yellow Soil',
        image: Image.asset(
          'assets/images/red-yellow.png',
          fit: BoxFit.fill,
        ),
        index: 2),
    Soil(
        title: 'Laterite Soil',
        image: Image.asset(
          'assets/images/laterite.png',
          fit: BoxFit.fill,
        ),
        index: 3),
    Soil(
        title: 'Arid Soil',
        image: Image.asset(
          'assets/images/arid.png',
          fit: BoxFit.fill,
        ),
        index: 4),
    Soil(
        title: 'Mountain and Forest Soil',
        image: Image.asset(
          'assets/images/mountain.png',
          fit: BoxFit.fill,
        ),
        index: 5),
    Soil(
        title: 'Desert Soil',
        image: Image.asset(
          'assets/images/desert.png',
          fit: BoxFit.fill,
        ),
        index: 6)
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: MediaQuery.of(context).size.height - 80,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 94, 192, 97),
          appBar: AppBar(
            title: Text('Soilpedia',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )),
            backgroundColor: Color.fromARGB(255, 94, 192, 97),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: soils.map((soil) {
                return SoilCard(soil: soil);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class Soil {
  String title;
  Image image;
  int index;

  Soil({required this.title, required this.image, required this.index});
}

class Detail {
  String name;
  String about;
  String found;
  String character;
  String crop;
  String photo;

  Detail(
      {required this.name,
      required this.about,
      required this.found,
      required this.character,
      required this.crop,
      required this.photo});
}
