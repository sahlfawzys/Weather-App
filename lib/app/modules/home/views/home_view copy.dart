import 'dart:html';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView1 extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HomeView is working in ${controller.regions}',
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.DETAIL_PAGE, arguments: 45);
                    },
                    child: Text('get data'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: controller.textProvince,
                    // autofillHints: controller.listProvince,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.cyanAccent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                  ),
                  DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      dropdownSearchDecoration: InputDecoration(
                        label: Text('country'),
                        hintText: 'choose country',
                      ),
                      items: [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                      selectedItem: "Brazil"),
                ],
              ),
            ),
          );
        }
        return FutureBuilder(
          future: controller.initState(),
          builder: (context, snapshot) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
