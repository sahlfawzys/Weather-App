import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailPageView '),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'DetailPageView is working ${controller.id}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.getDataWeather();
                print(controller.forecast.city!.name);
              },
              child: Text('GET'),
            )
          ],
        ),
      ),
    );
  }
}
