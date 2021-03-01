import 'package:flutter/material.dart';
import 'package:weather_app_2/providers/weather_api.dart';
import 'package:provider/provider.dart';

class FindTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final _controller = TextEditingController();
    return (context.watch<WeatherApi>().getIsLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: <Widget>[
              Container(
                width: 300,
                child: TextField(
                  controller: _controller,
                  onSubmitted: (newLocation) async {
                    try {
                      await context
                          .read<WeatherApi>()
                          .fetchWeatherInfo(newLocation);
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
            ],
          );
  }
}
