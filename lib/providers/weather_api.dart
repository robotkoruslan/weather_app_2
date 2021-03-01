import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const int daysForecast = 7;

class WeatherApi with ChangeNotifier {
  final _minTemperatureForecast2 =
      List<dynamic>.generate(daysForecast, (index) => null);
  final _maxTemperatureForecast2 =
      List<dynamic>.generate(daysForecast, (index) => null);
  final _abbreviationForecast2 =
      List<dynamic>.generate(daysForecast, (index) => null);

  String _location;
  int _woeid;
  int _temperature;
  int _maxTemperatureForecast;
  int _minTemperatureForecast;
  String _abbrevation = '';
  String _weather = 'clear';
  bool _isLoading = false;

  List get getMinTemperatureForecast2 => _minTemperatureForecast2;
  List get getmaxTemperatureForecast2 => _maxTemperatureForecast2;
  List get getabbreviationForecast2 => _abbreviationForecast2;
  String get getLocation => _location;
  String get abbrevation => _abbrevation;
  String get getWeather => _weather;
  int get getTemperature => _temperature;
  int get getMaxTemperature => _maxTemperatureForecast;
  int get getMinTemperature => _minTemperatureForecast;
  int get getWoeid => _woeid;
  bool get getIsLoading => _isLoading;

  Future<void> fetchWeatherInfo(String newLocation) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Get Where On Earth IDentifier
      var woeId = await http.get(
          'https://www.metaweather.com/api/location/search/?query=' +
              newLocation);
      var result = await json.decode(woeId.body)[0];
      _location = result['title'];
      _woeid = result['woeid'];

      // Get Current Day Forecast
      var currentForecast = await http
          .get('https://www.metaweather.com/api/location/' + _woeid.toString());
      var weatherResult = json.decode(currentForecast.body);
      var data = weatherResult["consolidated_weather"][0];
      _temperature = data["the_temp"].round();
      _maxTemperatureForecast = data["min_temp"].round();
      _minTemperatureForecast = data["max_temp"].round();
      _weather = data["weather_state_name"].replaceAll(' ', '').toLowerCase();
      _abbrevation = data["weather_state_abbr"];

      // Get 7 Day Forecast
      await fetchSevenDaysForecast();

      // Catch some kind of error
    } on SocketException {
      _isLoading = false;
      notifyListeners();
      throw ('Check internet connections!');
    } on RangeError {
      _isLoading = false;
      notifyListeners();
      throw ('We can\'t find this city please check name of the city!');
    } on FormatException {
      _isLoading = false;
      notifyListeners();
      throw ('Please type name of the city!');
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw error;
    }
    _isLoading = false;
    notifyListeners();
  }

  //Use current geolocation
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var citylocation = await http.get(
          'https://www.metaweather.com/api/location/search/?lattlong=${position.latitude},${position.longitude}');
      _location = await json.decode(citylocation.body)[0]['title'];
      fetchWeatherInfo(_location);
    } on SocketException {
      throw ('Check internet connections!');
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchSevenDaysForecast() async {
    var today = new DateTime.now();
    try {
      for (var i = 0; i < daysForecast; i++) {
        var locationDayResult = await http.get(
            'https://www.metaweather.com/api/location/' +
                _woeid.toString() +
                '/' +
                new DateFormat('y/M/d')
                    .format(today.add(new Duration(days: i + 1)))
                    .toString());
        var result = json.decode(locationDayResult.body)[0];

        _abbreviationForecast2[i] = result["weather_state_abbr"];
        _minTemperatureForecast2[i] = result["min_temp"].round().toString();
        _maxTemperatureForecast2[i] = result["max_temp"].round().toString();
        _isLoading = false;
      }
    } catch (error) {
      throw error;
    }
  }
}
