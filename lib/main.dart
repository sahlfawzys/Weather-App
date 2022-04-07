import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_app/app/controllers/initial_data_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final initD = Get.put(InitialDataController());

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   title: "Application",
    //   initialRoute: AppPages.INITIAL,
    //   getPages: AppPages.routes,
    // );
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 4)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        }
        return FutureBuilder(
          // future: initD,
          builder: (context, snapshot) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
