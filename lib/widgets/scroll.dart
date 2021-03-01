import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/widgets/forecast_element.dart';
import 'package:weather_app_2/widgets/start_message.dart';

class WeatherScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (context.watch<WeatherApi>().getLocation == null ||
            context.watch<WeatherApi>().getIsLoading)
        ? startText()
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                for (var i = 0; i < 7; i++)
                  ForecastElement(
                      i + 1,
                      context.watch<WeatherApi>().getabbreviationForecast2[i],
                      context.watch<WeatherApi>().getMinTemperatureForecast2[i],
                      context
                          .watch<WeatherApi>()
                          .getMinTemperatureForecast2[i]),
              ],
            ),
          );
  }
}
