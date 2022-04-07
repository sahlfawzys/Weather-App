import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 4)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // 'HomeView is working in ${controller.regions[0]} + ${controller.province.value} + ${controller.city.value}',
                    'homeview',
                    style: const TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.getCityID();
                      controller.getDataWeather();
                      if (controller.cityID != null) {
                        Get.toNamed(Routes.DETAIL_PAGE,
                            arguments: controller.cityID);
                      } else {
                        Get.defaultDialog(
                          title: 'ID not found',
                          middleText: '',
                          onWillPop: () => Future.delayed(Duration(seconds: 1)),
                        );
                      }
                    },
                    child: const Text('get data'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: controller.textProvince,
                    // autofillHints: controller.listProvince,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.cyanAccent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                  ),
                  DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      dropdownSearchDecoration: const InputDecoration(
                        label: Center(child: Text('Provinsi')),
                      ),
                      items: controller.provinceList,
                      onChanged: (s) {
                        controller.province.value = s!;
                        controller.getCityList();
                        controller.city.value = controller.cityList[0];
                      }),
                  Obx(
                    () => DropdownSearch<String>(
                      enabled:
                          (controller.province.value != 'none') ? true : false,
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      dropdownSearchDecoration: const InputDecoration(
                        label: Center(child: Text('Kota/Kabupaten')),
                        hintText: 'choose country',
                      ),
                      items: controller.cityList,
                      selectedItem: (controller.cityList.isNotEmpty)
                          ? controller.city.value
                          : null,
                      onChanged: (s) {
                        controller.city.value = s!;
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return FutureBuilder(
          future: controller.initState(),
          builder: (context, snapshot) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
