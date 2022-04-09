import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:weather_app/app/data/models/forecast_weather_model.dart';

import '../../../data/models/forecast_weather_model.dart';

class DetailPageController extends GetxController {
  String user = Get.arguments[0];
  ForecastWeather forecast = Get.arguments[1];
  List<List<Lists>> weekList = Get.arguments[2];
  String iconUrl = 'http://openweathermap.org/img/wn/10d@2x.png';

  Future<void> getDataWeather() async {
    String url_f =
        'http://api.openweathermap.org/data/2.5/forecast?id=${forecast.city!.id.toString()}&appid=a8284860c202f01eebb3f9dbad57f0e5&units=metric';
    try {
      final response = await http.get(Uri.parse(url_f));
      forecast = ForecastWeather.fromJson(json.decode(response.body));
    } catch (_) {}
  }

  void addWeekList() {
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

  String greet(int hour) {
    if (hour < 6) {
      return 'Malam';
    } else if (hour < 12) {
      return 'Pagi';
    } else if (hour < 15) {
      return 'Siang';
    } else if (hour < 18) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }
}
