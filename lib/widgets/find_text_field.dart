import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_data_provider.dart';
import 'package:provider/provider.dart';

class FindTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return (context.watch<WeatherDataProvider>().loading)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: <Widget>[
              SizedBox(
                width: 300,
                child: TextField(
                  onSubmitted: (city) {
                    try {
                      context.read<WeatherDataProvider>().getWeatherData(city);
                      TextEditingController().clear();
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
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                  decoration: const InputDecoration(
                    hintText: 'Search another location...',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
  }
}
