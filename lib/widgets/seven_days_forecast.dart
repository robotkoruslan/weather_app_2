import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/widgets/forecast_element.dart';

class SevenDaysForecast extends StatelessWidget {
  int dayFromNow;
  String abbreviationForecast;
  int maxTemperature;
  int minTemperature;

  SevenDaysForecast(
      {this.dayFromNow,
      this.abbreviationForecast,
      this.maxTemperature,
      this.minTemperature});

  @override
  Widget build(BuildContext context) {
    final weatherApi = context.watch<WeatherApi>();

    return (weatherApi.isLoaded)
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                for (var i = 0; i < 7; i++)
                  ForecastElement(
                      dayFromNow = i,
                      abbreviationForecast =
                          weatherApi.getabbreviationForecast2[dayFromNow],
                      maxTemperature =
                          weatherApi.getmaxTemperatureForecast2[dayFromNow],
                      minTemperature =
                          weatherApi.getMinTemperatureForecast2[dayFromNow]),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(40),
            child: const Text(
              "City isn't selected, please find location or use current location.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          );
  }
}
