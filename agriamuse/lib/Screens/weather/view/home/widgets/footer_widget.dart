import 'package:agriamuse/Screens/weather/utils/constants.dart';
import 'package:agriamuse/Screens/weather/view_model/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'OpenWeather',
            style: lightBodyTextStyle,
          ),
          Text(
            'Last updated ${globalController.dtValue()}',
            style: lightBodyTextStyle,
          ),
        ],
      ),
    );
  }
}
