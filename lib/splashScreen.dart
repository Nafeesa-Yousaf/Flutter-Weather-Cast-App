import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Color.fromARGB(255, 11, 30, 46), // Blue color
      Color.fromARGB(255, 68, 27, 24),
      Color(0xff081b25),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.3, 0.5, 1.0],
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage("splash.png"),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3),
                SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 10),
                    child: Text(
                      "Discover The Weather In your City",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 40,decoration: TextDecoration.none),textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
