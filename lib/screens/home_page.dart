import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_data_provider.dart';
import 'package:weather_app_2/widgets/current_weather.dart';
import 'package:weather_app_2/widgets/find_geolocation_button.dart';
import 'package:weather_app_2/widgets/find_text_field.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/${context.watch<WeatherDataProvider>().weather.condition ?? 'c'}.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CurrentWeather(),
                  FindTextField(),
                  FindGeolocationButton(),
                ],
              ),
            )),
      );
}
