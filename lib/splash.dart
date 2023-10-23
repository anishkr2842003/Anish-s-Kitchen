import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kitchen_recipe/home.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: 300,
                  width: 300,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome to',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, height: 1),
            ),
            Text(
              "Anish's Kitchen",
              style: TextStyle(
                  fontSize: 35, fontWeight: FontWeight.bold, height: 1),
            ),
            SizedBox(height: 50,),
            SpinKitWave(
              color: Colors.white,
              size: 80.0,
            )
          ],
        ),
      ),
    );
  }
}
