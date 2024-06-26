import 'package:agriamuse/Screens/weather/utils/constants.dart';
import 'package:agriamuse/Screens/weather/view/home/widgets/components/frosted_container.dart';
import 'package:flutter/material.dart';

class VerticalContainer extends StatelessWidget {
  final String label, value;
  final String imagePath;

  const VerticalContainer(
      {super.key,
      required this.label,
      required this.value,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return FrostedContainer(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            Text(
              label,
              style: lightTitleTextStyle,
            ),
            Text(
              value,
              style: titleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
