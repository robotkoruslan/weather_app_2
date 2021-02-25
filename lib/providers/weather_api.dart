import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherApi with ChangeNotifier {
  // ignore: deprecated_member_use
  var _minTemperatureForecast2 = new List(7);
  // ignore: deprecated_member_use
  var _maxTemperatureForecast2 = new List(7);
  // ignore: deprecated_member_use
  var _abbreviationForecast2 = new List(7);
  String _location;
  int _woeid;
  String _errorMessage = '';
  Position _currentPosition;
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
  String get getErrorMessage => _errorMessage;
  String get abbrevation => _abbrevation;
  String get getWeather => _weather;
  int get getTemperature => _temperature;
  int get getMaxTemperature => _maxTemperatureForecast;
  int get getMinTemperature => _minTemperatureForecast;
  int get getWoeid => _woeid;
  bool get getIsLoading => _isLoading;

  void fetchWeatherInfo(String newLocation) async {
    print('Start');
    _isLoading = true;
    notifyListeners();
    try {
      var searchResult = await http.get(
          'https://www.metaweather.com/api/location/search/?query=' +
              newLocation);
      if (searchResult == null) {
        _errorMessage =
            "Sorry, we don't have information about this sity. Try another one.";
        return;
      }
      var result = await json.decode(searchResult.body)[0];
      _location = result['title'];
      _woeid = result['woeid'];

      var weatherInfo = await http
          .get('https://www.metaweather.com/api/location/' + _woeid.toString());
      var weatherResult = json.decode(weatherInfo.body);
      var consolidatedWeather = weatherResult["consolidated_weather"];
      var data = consolidatedWeather[0];
      _temperature = data["the_temp"].round();
      _maxTemperatureForecast = data["min_temp"].round();
      _minTemperatureForecast = data["max_temp"].round();
      _weather = data["weather_state_name"].replaceAll(' ', '').toLowerCase();
      _abbrevation = data["weather_state_abbr"];
      await fetchLocationDay();
      _errorMessage = '';
      notifyListeners();
    } catch (error) {
      _errorMessage =
          "Sorry, we don't have information about this sity. Try another one.";
      notifyListeners();
    }
  }

  void getCity() async {
    try {
      var citylocation = await http.get(
          'https://www.metaweather.com/api/location/search/?lattlong=${_currentPosition.latitude},${_currentPosition.longitude}');
      var result = json.decode(citylocation.body)[0];
      if (result == null) {
        _errorMessage = "Sorry, we can't find your location. Try again later.";
        return;
      }
      _location = result['title'];
      fetchWeatherInfo(_location);
    } catch (error) {
      _errorMessage =
          "Sorry, we don't have information about this sity. Try another one.";
    }
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      getCity();
    }).catchError((error) {
      _errorMessage =
          "Sorry, we don't have information about this sity. Try another one.";
      notifyListeners();
    });
  }

  Future<void> fetchLocationDay() async {
    var today = new DateTime.now();

    for (var i = 0; i < 7; i++) {
      var locationDayResult = await http.get(
          'https://www.metaweather.com/api/location/' +
              _woeid.toString() +
              '/' +
              new DateFormat('y/M/d')
                  .format(today.add(new Duration(days: i + 1)))
                  .toString());
      var result = json.decode(locationDayResult.body);
      var data = result[0];

      _abbreviationForecast2[i] = data["weather_state_abbr"];
      print(_abbreviationForecast2);
      _minTemperatureForecast2[i] = data["min_temp"].round().toString();
      _maxTemperatureForecast2[i] = data["max_temp"].round().toString();
      _isLoading = false;
    }
  }
}
