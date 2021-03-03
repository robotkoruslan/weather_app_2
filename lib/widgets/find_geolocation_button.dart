import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/providers/weather_api.dart';

class FindGeolocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Colors.transparent)),
            padding: const EdgeInsets.all(10),
            primary: Colors.transparent,
            textStyle: const TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () async {
            try {
              await context.read<WeatherApi>().currentLocation;
            } on Exception catch (e) {
              scaffold.showSnackBar(
                SnackBar(
                  content: Text(
                    "$e",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
          child: const Text('Use current location!')),
    );
  }
}
