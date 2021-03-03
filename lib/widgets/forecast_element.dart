import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastElement extends StatelessWidget {
  final int _daysFromNow;
  final String _abbreviation;
  final int _minTemperature;
  final int _maxTemperature;

  const ForecastElement(this._daysFromNow, this._abbreviation,
      this._minTemperature, this._maxTemperature);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final oneDayFromNow = now.add(Duration(days: _daysFromNow));

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
                      _abbreviation +
                      '.png',
                  width: 50,
                ),
              ),
              Text(
                'High: ' + '$_maxTemperature' + ' °C',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                'Low: ' + '$_minTemperature' + ' °C',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
