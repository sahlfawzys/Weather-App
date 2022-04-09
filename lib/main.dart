import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_app/app/modules/home/controllers/home_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
    // return FutureBuilder(
    //   future: controller.initState(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       print('beres');
    //       return GetMaterialApp(
    //         title: "Application",
    //         initialRoute: AppPages.INITIAL,
    //         getPages: AppPages.routes,
    //       );
    //     }
    //     return Center(child: CircularProgressIndicator());
    //   },
    // );
  }
}
