import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agriamuse/models/app_localization.dart';
import 'package:agriamuse/models/language.dart';
import 'package:agriamuse/main.dart'; // Import MyApp if not already imported

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  Language _selectedLanguage = Language.languageList()[0];

  void _changeLanguage(Language language) {
    setState(() {
      _selectedLanguage = language;
    });
    AppLocalizations.of(context).load();
    MyApp.setLocale(context, Locale(language.languageCode));
    print('Updated Locale: ${Locale(language.languageCode)}');
    print(
        'Translated Text: ${AppLocalizations.of(context).translate('SmartFarm')}');
  }

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context).translate('Agri Amuse'),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          DropdownButton(
            underline: SizedBox(),
            icon: Icon(Icons.language_outlined, color: Colors.black),
            value: _selectedLanguage,
            items: Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (lang) => DropdownMenuItem(
                    child: Text(lang.name),
                    value: lang,
                  ),
                )
                .toList(),
            onChanged: (language) {
              if (language != null) {
                _changeLanguage(language as Language);
              }
            },
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/img4.jpg',
                width: 300,
                height: 250,
              ),
              const SizedBox(height: 25),
              Text(
                AppLocalizations.of(context).translate("Phone Verification"),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context).translate(
                    "We need to register your phone before getting started"),
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade700),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              AppLocalizations.of(context).translate("Phone"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${countryController.text + phone}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        Phone.verify = verificationId;
                        Navigator.pushNamed(context, 'verify');
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Text(
                      AppLocalizations.of(context).translate("Send the code")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
