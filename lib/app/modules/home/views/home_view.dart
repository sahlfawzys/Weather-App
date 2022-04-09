import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.initState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      // 'HomeView is working in ${controller.regions[0]} + ${controller.province.value} + ${controller.city.value}',
                      'homeview',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: controller.user,
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
                        selectedItem: (controller.province.isNotEmpty)
                            ? controller.province.value
                            : null,
                        onChanged: (s) {
                          controller.province.value = s!;
                          controller.getCityList();
                          controller.city.value = controller.cityList[0];
                        }),
                    Obx(
                      () => DropdownSearch<String>(
                        enabled: (controller.province.value != 'none')
                            ? true
                            : false,
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        dropdownSearchDecoration: const InputDecoration(
                          label: Center(child: Text('Kota/Kabupaten')),
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
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await controller.getDataWeather().timeout(
                            Duration(seconds: 5),
                            onTimeout: () {
                              Get.defaultDialog(
                                title: 'Connection timeout',
                                middleText: '',
                              );
                            },
                          );
                          controller.addWeekList();
                          Get.toNamed(Routes.DETAIL_PAGE, arguments: [
                            controller.user.text,
                            controller.forecast,
                            controller.weekList
                          ]);
                        } catch (_) {
                          Get.defaultDialog(
                            title: 'Data not found',
                            middleText: '',
                          );
                        }
                      },
                      child: const Text('get data'),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
