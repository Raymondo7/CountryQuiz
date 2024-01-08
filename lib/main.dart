import 'package:flutter/material.dart';
import 'package:quiz/constants.dart';

import 'homepage.dart';

import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey,
              Colors.white,
              Colors.blueGrey
            ]
          )
        ),
        //color: Colors.white54,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/world.json',
                width: 600,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 25,),
              Text(appName.toUpperCase(),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: police,
                color: primaryColor
              ),)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}