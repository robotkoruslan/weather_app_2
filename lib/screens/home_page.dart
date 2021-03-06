import 'package:flutter/material.dart';
import 'package:weather_app_2/widgets/find_location.dart';
import 'package:weather_app_2/widgets/scroll.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';
import '../widgets/center_widget.dart';
import '../widgets/find_text_field.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'images/${context.watch<WeatherApi>().getWeather}.png'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: (!isPortrait)
                ? Container(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: WeatherScroll())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CenterWidget(),
                      WeatherScroll(),
                      FindTextField(),
                      FindLocation(),
                    ],
                  ),
          )),
    );
  }
}
