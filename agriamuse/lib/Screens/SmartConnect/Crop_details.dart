import 'package:agriamuse/models/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agriamuse/models/crop_model.dart';

class CropDetails extends StatelessWidget {
  final crop cropData;

  CropDetails({Key? key, required this.cropData}) : super(key: key);

  void call(String x) async {
    print(x);
    await launch('tel:$x');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(240, 70, 235, 123),
        title: Text(AppLocalizations.of(context).translate('Details')),
        leading: const Icon(FontAwesomeIcons.tools),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(cropData.pic),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context).translate('Crop Name:'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate(cropData.cropname),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context).translate('Selling Price:'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ("Rs. ") +
                  AppLocalizations.of(context).translate(cropData.msp) +
                  ("/Quintal"),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context).translate('Quantity:'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate(cropData.quantity) +
                  (" Quintals"),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              AppLocalizations.of(context).translate('Description:'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate(cropData.descr),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    call(AppLocalizations.of(context)
                        .translate(cropData.contact));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(240, 70, 235, 123),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.call),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('Contact Seller'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                /* ElevatedButton(
                  onPressed: () {
                    // Add to Cart functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('Add to Cart'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
