import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feel_better_fixed/auth/age_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  // --- Text constants ---
  final String _titlePrefix = "To personalize ";
  final String _titleHighlight = "Feel Better ";
  final String _titleSuffix = "Please,";
  final List<String> _fieldLabels = ["Enter First Name", "Enter Last Name"];
  final List<String> _hintTexts = [
    "Type your first name here",
    "Type your last name here",
  ];
  final String _continueText = "Continue";
  final String _backText = "Back";
  final String _disclaimerText = "By joining, you agree to the following\n";
  final String _termsText = "Terms of Service ";
  final String _privacyText = "Privacy Policy";

  final Color _highlightColor = const Color(0xFF65D080);

  bool _isloading = false;

  User? user = FirebaseAuth.instance.currentUser;

  void saveName() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both first and last names."),
        ),
      );
      return;
    }

    try {
      setState(() {
        _isloading = true;
      });
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final users = db.collection('users');
      final userDoc = await users
          .doc(user?.uid)
          .get(); // Replace 'user_id' with actual user ID

      if (userDoc.exists) {
        // Update existing user document
        await users.doc(user?.uid).update({
          'first_name': firstName,
          'last_name': lastName,
        });

        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const AgeScreen()));
      } else {
        throw Exception("User document does not exist.");
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error saving name: $e")));
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              RichText(
                text: TextSpan(
                  text: _titlePrefix,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: _titleHighlight,
                      style: TextStyle(color: _highlightColor),
                    ),
                    TextSpan(text: _titleSuffix),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // First Name Field
              Text(_fieldLabels[0]),
              const SizedBox(height: 8),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: _hintTexts[0],
                  hintStyle: TextStyle(color: _highlightColor),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Last Name Field
              Text(_fieldLabels[1]),
              const SizedBox(height: 8),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: _hintTexts[1],
                  hintStyle: TextStyle(color: _highlightColor),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _highlightColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    saveName();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _isloading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Icon(Icons.arrow_forward, color: Colors.white),
                      SizedBox(width: 10),
                      Text(_continueText),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Back Button
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: _highlightColor,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(_backText),
                ),
              ),

              const Spacer(),

              // Terms and Policy
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text.rich(
                    TextSpan(
                      text: _disclaimerText,
                      style: const TextStyle(fontSize: 12),
                      children: [
                        TextSpan(
                          text: _termsText,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: 'and '),
                        TextSpan(
                          text: _privacyText,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
