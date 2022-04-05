import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.loadJsonData();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.DETAIL_PAGE, arguments: 45);
                },
                child: Text('get data'))
          ],
        ),
      ),
    );
  }
}
