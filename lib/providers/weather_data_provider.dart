import 'package:flutter/material.dart';
import 'package:weather_app_2/models/weather.dart';
import 'package:weather_app_2/repositories/weather_repository.dart';

class WeatherDataProvider extends ChangeNotifier {
  Weather weather = Weather();
  bool loading = false;
  bool loaded = false;

  Future<void> getWeatherData(String city) async {
    try {
      loading = true;
      notifyListeners();
      weather = await WeatherRepository().getWeather(city);
      loading = false;
      loaded = true;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e);
    }
  }

  Future<void> getDataUsingGeolacation() async {
    try {
      loading = true;
      notifyListeners();
      weather = await WeatherRepository().getWeatherUsingGeolocation();
      loading = false;
      loaded = true;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e);
    }
  }
}
