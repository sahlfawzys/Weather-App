import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/app/routes/app_pages.dart';
import 'package:weather_app/widgets/big_text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.initState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(
                        text: 'Weather App',
                        size: 40,
                        color: Colors.lightBlue[300],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Masukkan username';
                            } else {
                              return null;
                            }
                          },
                          controller: controller.user,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                          ),
                        ),
                      ),
                      DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          dropdownSearchDecoration:
                              const InputDecoration(labelText: 'Province'),
                          items: controller.provinceList,
                          selectedItem: (controller.province.value != 'none')
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
                            labelText: 'City',
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
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await controller.getDataWeather().timeout(
                                const Duration(seconds: 5),
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
                              Get.dialog(
                                AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: Column(
                                    children: [
                                      Lottie.asset(
                                          'assets/lotties/not_found.json',
                                          repeat: false,
                                          fit: BoxFit.cover),
                                      BigText(
                                        text: 'Data not found',
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('get data'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
              body: const Center(child: CircularProgressIndicator()));
        });
  }
}
