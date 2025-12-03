import 'package:flutter/material.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:my_weather/services/weather_services.dart';
import 'package:my_weather/widgets/weather_widgets.dart';
import 'package:my_weather/widgets/weather_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherservices = WeatherServices();

  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  weather? _weather;

  // void getWeather() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     final weather = await _weatherservices.fetchWeather(_controller.text);
  //     setState(() {
  //       _weather = weather;
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Error Fetching Weather Data")));
  //   }
  // }

  void getWeather() async {
  if (_controller.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter a city name")),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final weather = await _weatherservices.fetchWeather(_controller.text);

    setState(() {
      _weather = weather;
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${e.toString()}")),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,

      // SMART MODERN GRADIENT
      decoration: BoxDecoration(
        gradient: _weather != null &&
                _weather!.description.toLowerCase().contains('rain')
            ? const LinearGradient(
                colors: [Color(0xff3a6073), Color(0xff16222a)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : _weather != null &&
                    _weather!.description.toLowerCase().contains('clear')
                ? const LinearGradient(
                    colors: [Color.fromARGB(255, 247, 113, 30), Color.fromARGB(255, 142, 133, 94)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : const LinearGradient(
                    colors: [Color.fromARGB(255, 64, 94, 89), Color(0xffACB6E5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // APP TITLE – simple but smart
              Text(
                "Weather App",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // INPUT FIELD – simple, clean, classy
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    hintText: "Enter Your City Name",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // SMART BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.35),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Get Weather",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CircularProgressIndicator(color: Colors.white),
                ),

              if (_weather != null) ...[
                const SizedBox(height: 15),

                // Smooth fade-in animation
                AnimatedOpacity(
                  opacity: 1,
                  duration: const Duration(milliseconds: 500),
                  child: WeatherCard(weather: _weather),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
}
