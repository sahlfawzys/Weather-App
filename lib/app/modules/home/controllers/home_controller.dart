import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather_app/app/data/models/city_list_model.dart';
import 'package:weather_app/app/data/models/regions_model.dart';

class HomeController extends GetxController {
  var province = 'none'.obs;
  var city = 'none'.obs;

  late TextEditingController textProvince;

  List<String> provinceList = [];
  List<String> cityList = [];
  List<Regions> regions = [];
  List<CityList> cityIDSelected = [];
  List<CityList> cityIDList = [];

  Future<void> loadJsonDataRegion() async {
    var jsonText = await rootBundle.loadString('models/regions.json');
    var data = json.decode(jsonText);
    if (data != null) {
      regions = <Regions>[];
      data.forEach((v) {
        regions.add(Regions.fromJson(v));
      });
    }
  }

  void getProvinceList() {
    for (Regions element in regions) {
      provinceList.add(element.provinsi!);
    }
  }

  void getCityList() {
    var selected =
        regions.firstWhere((element) => element.provinsi == province.value);
    cityList = selected.kota!;
  }

  Future<void> initState() async {
    await loadJsonDataRegion();
    getProvinceList();
  }

  Future<void> getCityID(String city_name) async {
    var jsonText = await rootBundle.loadString('models/city_id.json');
    var data = json.decode(jsonText);
    if (data != null) {
      cityIDList = <CityList>[];
      data.forEach((v) {
        cityIDList.add(CityList.fromJson(v));
      });
    }
    // cityIDList!.forEach((element) {
    //   // print('${element.name} -------- ${city_name.split('')[1]}');
    //   if (element.name == city_name.split(' ')[1]) {
    //     city.add(element);
    //   }
    // });

    for (CityList element in cityIDList) {
      if (element.name == city_name.split(' ')[1]) {
        cityIDSelected.add(element);
      }
    }

    for (var element in cityIDSelected) {
      print('${element.id} + ${element.name} + ${element.coord}');
    }
  }

  @override
  void onInit() {
    textProvince = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textProvince.dispose();
    super.onClose();
  }
}
