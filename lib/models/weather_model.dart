// class weather{
//   final String cityName;
//   final double temperature;
//   final String description;
//   final int humidtiy; 
//   final double windSpeed;
//   final int sunRise;
//   final int sunSet;



//   weather({
//     required this.cityName,
//     required this.description,
//     required this.humidtiy,
//     required this.sunRise,
//     required this.sunSet,
//     required this.temperature,
//     required this.windSpeed,
    
// });


// factory weather.fromJson(Map<String,dynamic> json){
//   return weather(cityName: json['name'],
//    description: json['weather'][['description']], 
//    humidtiy: json['main']['humidity'], 
//    sunRise: json['sys']['sunRise'], 
//    sunSet: json['sys']['sunSet'], 
//    temperature: json['main']['temp'] - 273.15, 
//    windSpeed: json['wind']['speed']);
// }
// }


class weather {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunRise;
  final int sunSet;

  weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunRise,
    required this.sunSet,
  });

  factory weather.fromJson(Map<String, dynamic> json) {
    return weather(
      cityName: json['name'],
      description: json['weather'][0]['description'], // FIXED
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed']).toDouble(),
      sunRise: json['sys']['sunrise'], // FIXED KEY
      sunSet: json['sys']['sunset'],   // FIXED KEY

      // If you use metric units in API, no conversion needed:
      // temperature: json['main']['temp']
      temperature: json['main']['temp'] - 273.15, // If no metric
    );
  }
}

