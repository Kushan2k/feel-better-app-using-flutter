import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feel_better_fixed/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selectedGender;

  // Text Constants
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final String _titlePrefix = "To personalize ";
  final String _appName = "Feel Better ";
  final String _titleSuffix = "Please,";
  final String _subtitle = "Choose Your Gender";
  final String _continueText = "Continue";
  final String _backText = "Back";
  final String _termsPrefix = "By joining, you agree to the following\n";
  final String _termsLink = "Terms of Service ";
  final String _privacyText = "and ";
  final String _privacyLink = "Privacy Policy";

  final Color _highlightColor = const Color(0xFF65D080);

  bool _isloading = false;

  User? user = FirebaseAuth.instance.currentUser;

  void saveGender() async {
    if (_selectedGender == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter valid age.")));
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
        await users.doc(user?.uid).update({'gender': _selectedGender});

        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        throw Exception("User document does not exist.");
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error saving gender: $e")));
    } finally {
      setState(() {
        _isloading = false;
      });
    }
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
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: _appName,
                      style: TextStyle(color: _highlightColor),
                    ),
                    TextSpan(text: _titleSuffix),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Gender buttons
              ..._genderOptions.map((option) {
                final isSelected = _selectedGender == option;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedGender = option;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? _highlightColor
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        color: isSelected ? _highlightColor : Colors.white,
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 30),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _highlightColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: _selectedGender != null
                      ? () {
                          saveGender();
                        }
                      : null,
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

              // Back button
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
                      text: _termsPrefix,
                      style: const TextStyle(fontSize: 12),
                      children: [
                        TextSpan(
                          text: _termsLink,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(text: _privacyText),
                        TextSpan(
                          text: _privacyLink,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
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
