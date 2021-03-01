import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/providers/weather_api.dart';

class FindLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Container(
      margin: EdgeInsets.all(10),
      height: 50.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.transparent)),
            padding: EdgeInsets.all(10.0),
            primary: Colors.transparent,
            textStyle: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () async {
            try {
              await context.read<WeatherApi>().getCurrentLocation();
            } catch (error) {
              scaffold.showSnackBar(
                SnackBar(
                  content: Text(
                    "$error",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
          child: Text('Use current location!')),
    );
  }
}
