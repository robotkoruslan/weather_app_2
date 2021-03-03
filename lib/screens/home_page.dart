import 'package:flutter/material.dart';
import 'package:weather_app_2/widgets/find_geolocation_button.dart';
import 'package:weather_app_2/widgets/seven_days_forecast.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/widgets/current_weather.dart';
import 'package:weather_app_2/widgets/find_text_field.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'images/${context.watch<WeatherApi>().getWeather}.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: (!isPortrait)
                ? Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: SevenDaysForecast())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CurrentWeather(),
                      SevenDaysForecast(),
                      FindTextField(),
                      FindGeolocationButton(),
                    ],
                  ),
          )),
    );
  }
}
