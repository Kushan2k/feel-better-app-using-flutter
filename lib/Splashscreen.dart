import 'package:feel_better_fixed/Secondsplash.dart';
import 'package:feel_better_fixed/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFEAFCEF); // Light green background
  static const Color botGreen = Color(0xFF65D080); // Robot green
  static const Color textPrimary = Color(0xFF3A3A3A); // Dark gray text
  static const Color subtitle = Color(0xFF5A5A5A); // Light gray text
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bg1.png', // Replace with your background image path
              fit: BoxFit.cover, // Cover the entire screen
            ),
          ),

          // Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Clickable Robot Image to Navigate to SecondSplash
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Secondsplash()),
                    );
                  },
                  child: Image.asset(
                    'assets/splash.png', // Replace with your robot image path
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// SecondSplash Screen
