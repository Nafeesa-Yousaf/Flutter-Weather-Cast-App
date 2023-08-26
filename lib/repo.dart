import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/Weather_model.dart';

class repo{
  getWeather(String? city) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=83f05ffcad423469017b8d58ed2bf6a2";

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String,dynamic> jsonResponse = json.decode(response.body);
      WeatherModel weather = WeatherModel.fromJson(jsonResponse);
      return weather;
      
    } else {
      //nothing
      
    }
  }
}