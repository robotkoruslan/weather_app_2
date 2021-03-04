import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const int daysForecast = 7;

class WeatherApi extends ChangeNotifier {
  final _forecastMinTemperature =
      List<int>.generate(daysForecast, (index) => null);
  final _forecastMaxTemperature =
      List<int>.generate(daysForecast, (index) => null);
  final _forecastWeatherAbbreviation =
      List<String>.generate(daysForecast, (index) => null);

  String _location;
  int _woeid;
  int _currentTemperature;
  String _currentWeatherAbbrevation = '';
  String _weather = 'clear';
  bool _isLoading = false;
  bool _isLoaded = false;

  List<int> get getForecastMinTemperature => _forecastMinTemperature;
  List<int> get getForecastMaxTemperature => _forecastMaxTemperature;
  List<String> get getForecastWeatherAbbreviation =>
      _forecastWeatherAbbreviation;
  String get getLocation => _location;
  String get getCurentWeatherAbbrevation => _currentWeatherAbbrevation;
  String get getWeather => _weather;
  int get getCurrentTemperature => _currentTemperature;
  int get getWoeid => _woeid;
  bool get isLoading => _isLoading;
  bool get isLoaded => _isLoaded;

  Future<void> fetchWeatherInfo(String newLocation) async {
    _isLoading = true;
    notifyListeners();

    void stopAndNotify() {
      _isLoading = false;
      notifyListeners();
    }

    try {
      // Get Where On Earth IDentifier
      final woeId = await http.get(
          'https://www.metaweather.com/api/location/search/?query=' +
              newLocation);
      final result = await json.decode(woeId.body)[0];
      _location = result['title'] as String;
      _woeid = result['woeid'] as int;

      // Get Current Day Forecast
      final currentForecast = await http
          .get('https://www.metaweather.com/api/location/' + _woeid.toString());
      final weatherResult = json.decode(currentForecast.body);
      final data = weatherResult["consolidated_weather"][0];
      _currentTemperature = data["the_temp"].round() as int;
      _weather = data["weather_state_name"].replaceAll(' ', '').toLowerCase()
          as String;
      _currentWeatherAbbrevation = data["weather_state_abbr"] as String;

      // Get 7 Day Forecast
      await _fetchSevenDaysForecast();

      // Catch some kind of error
    } on SocketException {
      stopAndNotify();
      throw 'Check internet connections!';
    } on FormatException {
      stopAndNotify();
      throw 'Please type name of the city!';
    } on RangeError {
      stopAndNotify();
      throw "Sorry we can't the city!";
    } catch (error) {
      stopAndNotify();
      throw 'Somthing was wrong!';
    }
    stopAndNotify();
  }

  //Use current geolocation
  Future<void> get currentGeolocation async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final citylocation = await http.get(
          'https://www.metaweather.com/api/location/search/?lattlong=${position.latitude},${position.longitude}');
      _location = await json.decode(citylocation.body)[0]['title'] as String;
      await fetchWeatherInfo(_location);
    } on SocketException {
      throw const SocketException('Check internet connections!');
    }
  }

  Future<void> _fetchSevenDaysForecast() async {
    final today = DateTime.now();
    try {
      for (var i = 0; i < daysForecast; i++) {
        final locationDayResult = await http.get(
            'https://www.metaweather.com/api/location/' +
                _woeid.toString() +
                '/' +
                DateFormat('y/M/d')
                    .format(today.add(Duration(days: i + 1)))
                    .toString());
        final result = json.decode(locationDayResult.body);
        final data = result[0];

        _forecastWeatherAbbreviation[i] = data["weather_state_abbr"] as String;
        print(_forecastWeatherAbbreviation);
        _forecastMinTemperature[i] = data["min_temp"].round() as int;
        _forecastMaxTemperature[i] = data["max_temp"].round() as int;
        _isLoading = false;
        _isLoaded = true;
      }
    } on Exception {
      throw 'Somthing was wrong!';
    }
  }
}
