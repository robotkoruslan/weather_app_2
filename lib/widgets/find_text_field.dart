import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';

class FindTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Column(
      children: <Widget>[
        Container(
          width: 300,
          child: TextField(
            controller: _controller,
            onSubmitted: (newLocation) {
              context.read<WeatherApi>().fetchWeatherInfo(newLocation);
              _controller.clear();
            },
            style: TextStyle(color: Colors.white, fontSize: 25),
            decoration: InputDecoration(
              hintText: 'Search another location...',
              hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
              prefixIcon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
        Text(
          context.watch<WeatherApi>().getErrorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
