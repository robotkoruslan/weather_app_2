import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/weather_api.dart';
import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherApi>(
      create: (context) => WeatherApi(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
