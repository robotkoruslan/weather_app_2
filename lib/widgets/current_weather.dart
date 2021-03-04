import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';

class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherApi = context.watch<WeatherApi>();
    return (weatherApi.isLoaded)
        ? Column(
            children: <Widget>[
              Center(
                  child: Image.network(
                'https://www.metaweather.com/static/img/weather/png/' +
                    weatherApi.getCurentWeatherAbbrevation +
                    '.png',
                width: 100,
              )),
              Center(
                child: Text(
                  weatherApi.getCurrentTemperature.toString() + ' °C',
                  style: const TextStyle(color: Colors.white, fontSize: 60),
                ),
              ),
              Center(
                child: Text(
                  weatherApi.getLocation,
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
            ],
          )
        : Container();
  }
}
