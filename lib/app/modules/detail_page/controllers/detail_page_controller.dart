import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/app/data/models/forecast_weather_model.dart';

import '../../../data/models/forecast_weather_model.dart';

class DetailPageController extends GetxController {
  ForecastWeather forecast = ForecastWeather();
  // late int id = Get.arguments;
  int id = 7780172;

  Future<void> getDataWeather() async {
    String url_f =
        'http://api.openweathermap.org/data/2.5/forecast?id=${id.toString()}&appid=a8284860c202f01eebb3f9dbad57f0e5&units=metric';
    try {
      final response = await http.get(Uri.parse(url_f));
      print('Data imported');

      forecast = ForecastWeather.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
