import 'package:my_weather/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherServices {

  final String apikey='e599be7a507e0fada3e906c92510f1bd';

  Future<weather> fetchWeather(String cityName) async{
 final uri = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey');

 final response=await http.get(uri);

 if(response.statusCode==200){
  return weather.fromJson(json.decode(response.body));
 }else{
  throw Exception('Failed to Load Weather Data');
 }
  }
}