import 'package:agriamuse/models/app_localization.dart';
import 'package:agriamuse/models/rent_tools_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  final Rent rentTools;
  Details({Key? key, required this.rentTools}) : super(key: key);

  call(String x) async {
    print(x);
    // ignore: deprecated_member_use
    await launch('tel:$x');
  }

  final Color primaryColor = const Color(0xFF66BB6A);
  final Color secondaryColor = const Color(0xff324558);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(240, 70, 235, 123),
        title: const Text('Details'),
        leading: const Icon(FontAwesomeIcons.tools),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Image.network(
                rentTools.pic,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context).translate("Product Name: ") +
                  AppLocalizations.of(context)
                      .translate(rentTools.name.toString()),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              AppLocalizations.of(context).translate("Category: ") +
                  AppLocalizations.of(context).translate(rentTools.category),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              AppLocalizations.of(context).translate("Cost: ") +
                  ("Rs. ") +
                  AppLocalizations.of(context).translate(rentTools.cost) +
                  ("/day"),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context).translate("Description: ") +
                  AppLocalizations.of(context).translate(rentTools.desc),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(240, 70, 235, 123),
              ),
              onPressed: () {
                call(rentTools.contactinfo);
              },
              icon: Icon(Icons.call),
              label: Text(
                AppLocalizations.of(context).translate("Contact"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
