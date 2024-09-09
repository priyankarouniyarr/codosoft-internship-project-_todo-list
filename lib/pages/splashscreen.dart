import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showAnimation = false;

  @override
  void initState() {
    super.initState();

    // Show a white screen for 2 seconds, then show the animation
    Timer(Duration(seconds: 2), () {
      setState(() {
        showAnimation = true;
      });
    });

    
    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: showAnimation
            ? Lottie.asset(
                'Animation/task done.json', 
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height/3,
              
                fit: BoxFit.fill,
              )
            : Container(), 
      ),
    );
  }
}
