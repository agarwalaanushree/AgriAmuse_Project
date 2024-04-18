import 'package:agriamuse/Screens/Crop/recommendation.dart';
import 'package:agriamuse/Screens/DiseaseDetection/screens/upload_screen.dart';
import 'package:agriamuse/Screens/RentTools/Rent_tools.dart';
import 'package:agriamuse/Screens/SmartConnect/smart_connect.dart';
import 'package:agriamuse/constants/color.dart';
import 'package:agriamuse/constants/size.dart';
import 'package:agriamuse/models/app_localization.dart';
import 'package:agriamuse/models/category.dart';
import 'package:agriamuse/widgets/circle_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: const [
            AppBar(),
            Body(),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate("Explore Categories"),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context).translate("See All"),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: kPrimaryColor),
                ),
              )
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categoryList[index],
            );
          },
          itemCount: categoryList.length,
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (category.name == 'Rent Tools') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RentTools(),
            ),
          );
        } else if (category.name == 'Sell Crops') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Crops(),
            ),
          );
        } else if (category.name == 'Disease Detection') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadScreen(),
            ),
          );
        } else if (category.name == 'Crop Recommendation') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Crop_Recommend(),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                category.thumbnail,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(AppLocalizations.of(context).translate(category.name)),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(
          context, 'welcome'); // Navigate to login screen
    } catch (e) {
      print('Error signing out: $e');
      // Show snackbar or dialog with error message if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color.fromARGB(255, 28, 254, 31),
            Color.fromARGB(255, 111, 226, 126),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)
                    .translate("Hello,\nWelcome to AgriAmuse"),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () =>
                    _signOut(context), // Call _signOut function on button press
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //_buildLanguageDropdown(context), // Add language dropdown here
          //const SearchTextField()
        ],
      ),
    );
  }

  /* Widget _buildLanguageDropdown(BuildContext context) {
    return DropdownButton<String>(
      value: AppLocalizations.of(context)
          .locale
          .languageCode, // Current language code
      onChanged: (String? newValue) {
        if (newValue != null) {
          _changeLanguage(context, newValue);
        }
      },
      items: <String>['en', 'hi'] // Add your supported language codes here
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(_getDisplayLanguage(value)),
            ),
          )
          .toList(),
    );
  } */

  /*  void _changeLanguage(BuildContext context, String languageCode) {
    Locale newLocale = Locale(languageCode, '');
    AppLocalizations.of(context).load().then((_) {
      // Perform any necessary state updates or navigation
    });
  } */

  String _getDisplayLanguage(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिंदी';
      default:
        return 'Unknown';
    }
  }
}
