import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/Weather_model.dart';
import 'package:weather/repo.dart';

class Weather_Home_Page extends StatefulWidget {
  @override
  State<Weather_Home_Page> createState() => _Weather_Home_PageState();
}

class _Weather_Home_PageState extends State<Weather_Home_Page> {
  TextEditingController city = TextEditingController();
  WeatherModel? w;
  var weather;
  FocusNode _textFieldFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff081b25),
        title: TextField(
          controller: city,
          enabled: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            hintText: "Search City",
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                w = await repo().getWeather(city.text);
                weather = w?.weather[0];
                setState(() {});
              },
              child: Text("Search"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff081b25)),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: repo().getWeather(city.text),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (w?.cod == 200) {
                if (w?.weather[0].main == "Clear") {
                  return Display_Weather(size, "sunny.png");
                } else if (w?.weather[0].main == "rain") {
                  return Display_Weather(size, "rainy.png");
                } else if (w?.weather[0].main == "Smoke") {
                  return Display_Weather(size, "smoke.jpg");
                } else if (w?.weather[0].main == "Clouds") {
                  return Display_Weather(size, "cloudy.png");
                } else {
                  return Display_Weather(size, "party_cloudy.png");
                }
              } else {
                return Center(
                  child: Text(
                    "City Not Found",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 35),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "City Not Found",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 35),
                ),
              );
            } else if (city.text.isEmpty ) {
              return Center(
                child: Image(
                    image: AssetImage("WeatherSplash.png"),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3),
              );
            } else {
              return Center(
                child: Text(
                  "City Not Found",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 35),
                ),
              );
            }
          }),
    );
  }

  Container Display_Weather(Size size, String img) {
    var temp = (w?.main.temp)! - 273.15;
    var temp_max = (w?.main.tempMax)! - 273.15;
    var temp_min = (w?.main.tempMin)! - 273.15;
    var temp_feel = (w?.main.feelsLike)! - 273.15;
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            height: size.height * 0.7,
            margin: EdgeInsets.only(right: 10, left: 10),
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                    colors: [Color(0xff955cd1), Color(0xff3fa2fa)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.2, 0.85])),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "${w?.name}",
                    style: GoogleFonts.montserrat(
                        color: Colors.white.withOpacity(0.9), fontSize: 35),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${Date(w?.dt ?? 0)}",
                    style: GoogleFonts.montserrat(
                        color: Colors.white.withOpacity(0.9), fontSize: 15),
                  ),
                  Image.asset(
                    "$img",
                    width: size.width * 0.3,
                  ),
                  Text(
                    "${w?.weather[0].description}",
                    style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.9), fontSize: 36),
                  ),
                  Text(
                    "${temp.toStringAsFixed(2)}°C",
                    style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 42,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              "wind.png",
                              width: size.width * 0.1,
                            ),
                            Text(
                              "${(w!.wind.speed * 3.6).toStringAsFixed(2)} km/h",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Wind",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              "humidity.png",
                              width: size.width * 0.1,
                            ),
                            Text(
                              "${w?.main.humidity} %",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Humidity",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              "wind_direction.png",
                              width: size.width * 0.1,
                            ),
                            Text(
                              "${w?.wind.deg}°",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Wind Direction",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Text(
                    "Max Temp",
                    style: GoogleFonts.montserrat(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${temp_max.toStringAsFixed(2)}°C",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pressure",
                    style: GoogleFonts.montserrat(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${w?.main.pressure} hPa",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    "Min Temp",
                    style: GoogleFonts.montserrat(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${temp_min.toStringAsFixed(2)}°C",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Clouds",
                    style: GoogleFonts.montserrat(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${w?.clouds.all}%",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    "Feels Like",
                    style: GoogleFonts.montserrat(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${temp_feel.toStringAsFixed(2)}°C",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Last Update",
                    style: GoogleFonts.montserrat(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    " ${_convertUnixTimestampToDateTime(w?.dt ?? 0)}",
                    style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ))
            ],
          )
        ],
      ),
    );
  }

  String _convertUnixTimestampToDateTime(int unixTimestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    final formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }

  String Date(int unixTimestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    final formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDateTime;
  }
}
