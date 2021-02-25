import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';

class ForecastElement extends StatelessWidget {
  final daysFromNow;
  final abbreviation;
  final minTemperature;
  final maxTemperature;

  ForecastElement(this.daysFromNow, this.abbreviation, this.minTemperature,
      this.maxTemperature);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var oneDayFromNow = now.add(new Duration(days: daysFromNow));
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(205, 212, 228, 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                new DateFormat.E().format(oneDayFromNow),
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                new DateFormat.MMMd().format(oneDayFromNow),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Image.network(
                  'https://www.metaweather.com/static/img/weather/png/' +
                      abbreviation +
                      '.png',
                  width: 50,
                ),
              ),
              Text(
                'High: ' +
                    context.watch<WeatherApi>().getMaxTemperature.toString() +
                    ' °C',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              Text(
                'Low: ' + minTemperature.toString() + ' °C',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
