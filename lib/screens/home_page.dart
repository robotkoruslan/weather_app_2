import 'package:flutter/material.dart';
import 'package:weather_app_2/models/weather.dart';
import 'package:weather_app_2/repositories/weather_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Future<Weather> _futureWeather;
  String weatherBackground = 'clear';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$weatherBackground.png'),
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
                Center(
                  child: FutureBuilder<Weather>(
                    future: _futureWeather,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Image.network(
                              'https://www.metaweather.com/static/img/weather/png/${snapshot.data.abbreviation}.png',
                              width: 100,
                            ),
                            Text(
                              snapshot.data.temperatureInCelsius,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 60),
                            ),
                            Text(
                              snapshot.data.location,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 40),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "${snapshot.error}",
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 25),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.all(40),
                        child: const Text(
                          "City isn't selected, please find location or use current location.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (city) {
                          setState(() {
                            _futureWeather =
                                WeatherRepository().getWeather(city);
                          });
                        },
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                        decoration: const InputDecoration(
                          hintText: 'Search another location...',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(color: Colors.transparent)),
                        padding: const EdgeInsets.all(10),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      onPressed: () {
                        setState(() {
                          _futureWeather =
                              WeatherRepository().getWeatherUsingGeolocation();
                        });
                      },
                      child: const Text('Use current location!')),
                ),
              ],
            ),
          ),
        ),
      );
}
