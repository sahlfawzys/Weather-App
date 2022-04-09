import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/app/data/models/city_list_model.dart';
import 'package:weather_app/app/data/models/regions_model.dart';

import '../../../data/models/forecast_weather_model.dart';

class HomeController extends GetxController {
  var province = 'none'.obs;
  var city = 'none'.obs;
  int? cityID;

  late TextEditingController user;

  List<String> provinceList = [];
  List<String> cityList = [];
  List<Regions> regions = [];
  List<CityList> cityIDList = [];
  List<List<Lists>> weekList = [];

  ForecastWeather forecast = ForecastWeather();

  Future<void> getDataWeather() async {
    try {
      getCityID();
      String url =
          'http://api.openweathermap.org/data/2.5/forecast?id=${cityID.toString()}&appid=a8284860c202f01eebb3f9dbad57f0e5&units=metric';

      final response = await http.get(Uri.parse(url));

      forecast = ForecastWeather.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> loadJsonDataRegion() async {
    var jsonText = await rootBundle.loadString('assets/models/regions.json');
    var data = json.decode(jsonText);
    if (data != null) {
      regions = <Regions>[];
      data.forEach((v) {
        regions.add(Regions.fromJson(v));
      });
    }
  }

  Future<void> loadJsonDataCityID() async {
    var jsonText = await rootBundle.loadString('assets/models/city_id.json');
    var data = json.decode(jsonText);
    if (data != null) {
      cityIDList = <CityList>[];
      data.forEach((v) {
        cityIDList.add(CityList.fromJson(v));
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

  void getCityID() {
    List<CityList> cityIDSelected = [];
    String cityName = city.value
        .splitMapJoin(RegExp('${city.split(' ')[0]} '), onMatch: (m) => '');

    for (CityList element in cityIDList) {
      if (element.name == cityName) {
        cityIDSelected.add(element);
      }
    }

    if (cityIDSelected.isNotEmpty) {
      if (cityIDSelected.length > 1) {
        if (city.split(' ')[0] == 'Kota') {
          cityID = cityIDSelected[0].id;
        } else {
          cityID = cityIDSelected[1].id;
        }
      } else {
        cityID = cityIDSelected[0].id;
      }
    } else {
      cityID = null;
    }
  }

  void addWeekList() {
    weekList.clear();
    List<Lists> dayList = [];
    var day =
        DateFormat.EEEE().format(DateTime.parse(forecast.list![0].dtTxt!));
    for (Lists element in forecast.list!) {
      if (DateFormat.EEEE().format(DateTime.parse(element.dtTxt!)) != day) {
        weekList.add(dayList);
        day = DateFormat.EEEE().format(DateTime.parse(element.dtTxt!));
        dayList = [];
      }
      dayList.add(element);
    }
  }

  Future<void> initState() async {
    await loadJsonDataRegion();
    await loadJsonDataCityID();
    getProvinceList();
  }

  @override
  void onInit() {
    user = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    user.dispose();
    super.onClose();
  }
}
