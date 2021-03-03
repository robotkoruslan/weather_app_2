import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastElement extends StatelessWidget {
  final int daysFromNow;
  final String abbreviation;
  final int minTemperature;
  final int maxTemperature;

  const ForecastElement(this.daysFromNow, this.abbreviation,
      this.minTemperature, this.maxTemperature);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final oneDayFromNow = now.add(Duration(days: daysFromNow));
    final minTemperature2 = this.minTemperature;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(205, 212, 228, 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                DateFormat.E().format(oneDayFromNow),
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                DateFormat.MMMd().format(oneDayFromNow),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Image.network(
                  'https://www.metaweather.com/static/img/weather/png/' +
                      abbreviation +
                      '.png',
                  width: 50,
                ),
              ),
              Text(
                'High: ' + '$maxTemperature' + ' °C',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                'Low: ' + '$minTemperature2' + ' °C',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
