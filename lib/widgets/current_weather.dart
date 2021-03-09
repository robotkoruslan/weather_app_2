import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_data_provider.dart';
import 'package:provider/provider.dart';

class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherApi = context.watch<WeatherDataProvider>();
    return (weatherApi.loaded)
        ? Column(
            children: <Widget>[
              Center(
                  child: Image.network(
                'https://www.metaweather.com/static/img/weather/png/' +
                    weatherApi.weather.condition +
                    '.png',
                width: 100,
              )),
              Center(
                child: Text(
                  weatherApi.weather.currentTemperature.round().toString() +
                      ' °C',
                  style: const TextStyle(color: Colors.white, fontSize: 60),
                ),
              ),
              Center(
                child: Text(
                  weatherApi.weather.location,
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
            ],
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
