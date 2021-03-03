import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';

class CenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      (context.watch<WeatherApi>().abbrevation == null ||
              context.watch<WeatherApi>().getTemperature == null)
          ? const Center()
          : Column(
              children: <Widget>[
                Center(
                    child: Image.network(
                  'https://www.metaweather.com/static/img/weather/png/' +
                      context.watch<WeatherApi>().abbrevation +
                      '.png',
                  width: 100,
                )),
                Center(
                  child: Text(
                    context.watch<WeatherApi>().getTemperature.toString() +
                        ' °C',
                    style: const TextStyle(color: Colors.white, fontSize: 60),
                  ),
                ),
                Center(
                  child: Text(
                    context.watch<WeatherApi>().getLocation,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ],
            );
}
