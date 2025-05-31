import 'package:feel_better_fixed/auth/Login.dart' as login;
import 'package:feel_better_fixed/auth/Register.dart' as register;
import 'package:feel_better_fixed/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Secondsplash extends StatefulWidget {
  const Secondsplash({super.key});

  @override
  State<Secondsplash> createState() => _SecondsplashState();
}

class _SecondsplashState extends State<Secondsplash> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in, navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
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
              fit: BoxFit.cover,
            ),
          ),

          // Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Robot Image
                Image.asset(
                  'assets/splashicon.png', // Replace with your robot image path
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 20),

                // Main Title
                Text(
                  'Welcome to Feel Better.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A3A3A), // Dark gray
                  ),
                ),
                SizedBox(height: 10),

                // Subtitle
                Text(
                  'This app is designed to check early depression\nlevels and aims to help users feel comfortable.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF5A5A5A), // Light gray
                  ),
                ),
                SizedBox(height: 30),

                // Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIndicator(true),
                    SizedBox(width: 8),
                    _buildIndicator(false),
                    SizedBox(width: 8),
                    _buildIndicator(false),
                  ],
                ),
                SizedBox(height: 70),

                // Buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => register.SignUpScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF65D080), // Bot green color
                    padding: EdgeInsets.symmetric(
                      horizontal: 120,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Log In Link
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => login.SignInScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0), // Bot green color
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 50),

                // Terms and Privacy
                Text.rich(
                  TextSpan(
                    text: 'By joining, you agree to the following ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5A5A5A), // Light gray
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF65D080) : Color(0xFFCCCCCC),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
