import 'package:flutter/cupertino.dart';

class Weather extends ChangeNotifier {
  final String condition;
  final double currentTemperature;
  final int woeid;
  final String location;

  Weather({
    this.condition,
    this.currentTemperature,
    this.woeid,
    this.location,
  });

  static Weather fromJson(dynamic json) {
    final consolidatedWeather = json['consolidated_weather'][0];
    return Weather(
      condition: consolidatedWeather['weather_state_abbr'] as String,
      currentTemperature: consolidatedWeather['the_temp'] as double,
      woeid: json['woeid'] as int,
      location: json['title'] as String,
    );
  }
}
