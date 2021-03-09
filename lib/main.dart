import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/providers/weather_data_provider.dart';
import 'package:weather_app_2/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<WeatherDataProvider>(
        create: (context) => WeatherDataProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      );
}
