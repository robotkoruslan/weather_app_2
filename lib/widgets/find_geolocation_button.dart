import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/providers/weather_data_provider.dart';

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
              await context
                  .read<WeatherDataProvider>()
                  .getDataUsingGeolacation();
            } catch (error) {
              scaffold.showSnackBar(
                SnackBar(
                  content: Text(
                    '$error',
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
