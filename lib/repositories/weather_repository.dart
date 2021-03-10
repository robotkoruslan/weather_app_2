import 'dart:async';
import 'package:weather_app_2/models/weather.dart';
import 'package:weather_app_2/repositories/weather_api_client.dart';

class WeatherRepository {
  Future<Weather> getWeather(String city) async {
    final int locationId = await WeatherApiClient().getLocationId(city);
    return WeatherApiClient().fetchWeather(locationId);
  }

  Future<Weather> getWeatherUsingGeolocation() async {
    final currentCity = await WeatherApiClient().currentGeoLocation();
    final int locationId = await WeatherApiClient().getLocationId(currentCity);
    return WeatherApiClient().fetchWeather(locationId);
  }
}
