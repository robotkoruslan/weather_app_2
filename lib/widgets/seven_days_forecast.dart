import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/widgets/forecast_element.dart';

class SevenDaysForecast extends StatelessWidget {
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
                      i + 1,
                      weatherApi.getabbreviationForecast2[i],
                      weatherApi.getMinTemperatureForecast2[i],
                      weatherApi.getmaxTemperatureForecast2[i]),
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
