import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/Weater_Home.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 02),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Weather_Home_Page()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 33, 59),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage("WeatherSplash.png"), width: MediaQuery.of(context).size.width*0.3, height: MediaQuery.of(context).size.height*0.3),
                
          ],
        ),
      ),
    );
  }
}
