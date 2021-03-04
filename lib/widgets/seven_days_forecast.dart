import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/widgets/forecast_element.dart';

class SevenDaysForecast extends StatelessWidget {
  int dayFromNow;
  String forecastWeatherAbbreviation;
  int forecastMaxTemperature;
  int forecastMinTemperature;

  SevenDaysForecast(
      {this.dayFromNow,
      this.forecastWeatherAbbreviation,
      this.forecastMaxTemperature,
      this.forecastMinTemperature});

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
                      forecastWeatherAbbreviation =
                          weatherApi.getForecastWeatherAbbreviation[dayFromNow],
                      forecastMaxTemperature =
                          weatherApi.getForecastMaxTemperature[dayFromNow],
                      forecastMinTemperature =
                          weatherApi.getForecastMinTemperature[dayFromNow]),
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
