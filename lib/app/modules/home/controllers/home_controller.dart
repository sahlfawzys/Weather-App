import 'package:get/get.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather_app/app/data/models/city_list_model.dart';

class HomeController extends GetxController {
  String city_name = 'Kab. Bandung';
  List<CityList>? id;

  // void getID(String city_name) {}

  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString('models/city_id.json');
    var data = json.decode(jsonText);
    if (data != null) {
      id = <CityList>[];
      data.forEach((v) {
        id?.add(CityList.fromJson(v));
      });
    }
    List<CityList> city = [];
    id!.forEach((element) {
      // print('${element.name} -------- ${city_name.split('')[1]}');
      if (element.name == city_name.split(' ')[1]) {
        city.add(element);
      }
    });
    print(city);
  }
}
