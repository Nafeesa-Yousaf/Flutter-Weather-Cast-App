class WeatherModel {
  final int cod;
  final int timezone;
  final String name;
  final List<Weather> weather;
  final Main main;
  final Wind wind;
  final Clouds clouds;
  final int dt;

  WeatherModel({
    required this.cod,
    required this.timezone,
    required this.name,
    required this.weather,
    required this.main,
    required this.wind,
    required this.clouds,
    required this.dt,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cod: json['cod'],
      timezone: json['timezone'],
      name: json['name'],
      weather: List<Weather>.from(
        json['weather'].map((weatherJson) => Weather.fromJson(weatherJson)),
      ),
      main: Main.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
    );
  }
}

class Weather {
  final String main;
  final String description;

  Weather({
    required this.main,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: json['main'],
      description: json['description'],
    );
  }
}

class Main {
  final double temp;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double feelsLike;

  Main({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.feelsLike,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      humidity: json['humidity'],
      pressure: json['pressure'],
      feelsLike: json['feels_like'].toDouble(),
    );
  }
}

class Wind {
  final double speed;
  final int deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
    );
  }
}

class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}
