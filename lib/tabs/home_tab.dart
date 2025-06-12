import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feel_better_fixed/auth/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeTab extends StatefulWidget {
  final Function navigate;
  const HomeTab({super.key, required this.navigate});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _msg = 'Good Morning';
  String _name = "Unknown User";

  String _text = '';

  String _status = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuote();

    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      _msg = 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      _msg = 'Good Afternoon';
    } else {
      _msg = 'Good Evening';
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => SignInScreen()));
    } else {
      fetchName();
    }
  }

  void update_status(String status) {
    final db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'status': status})
        .then((value) {
          setState(() {
            _status = status;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Status updated to $status'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update status: $error'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        });
  }

  void fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('https://api.kanye.rest/'));
      if (response.statusCode == 200) {
        final data = response.body;

        final quote = jsonDecode(data)['quote'];
        setState(() {
          _text = quote;
        });
      } else {
        print('Failed to load quote====================');
        setState(() {
          _text =
              "This app is designed for check early depression level and it aims to help the users mental comfortable.";
        });
      }
    } catch (e) {
      print('Error fetching quote====================: $e');
      setState(() {
        _text =
            "This app is designed for check early depression level and it aims to help the users mental comfortable.";
      });
    }
  }

  void fetchName() async {
    final db = FirebaseFirestore.instance;

    db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
          if (value.exists) {
            debugPrint(value.data().toString());
            setState(() {
              _name = value.data()!['first_name'] ?? "User";
              _status = value.data()!['status'] ?? "Happy";
            });
          } else {
            setState(() {
              _name = "User";
              _status = "Happy";
            });
          }
        })
        .catchError((error) {
          print("Error fetching user data: $error");
        });
  }

  final List<Map<String, dynamic>> emotions = [
    {'label': 'Happy', 'color': Colors.yellow[200], 'emoji': '😊'},
    {'label': 'Healing', 'color': Colors.green[200], 'emoji': '🙂'},
    {'label': 'Depressed', 'color': Colors.blue[200], 'emoji': '😔'},
    {'label': 'Angry', 'color': Colors.red[200], 'emoji': '😡'},
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: Image.asset(
                      'assets/home_bg.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.1),
                          ],
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  AlertDialog alert = AlertDialog(
                                    shape: LinearBorder(),
                                    backgroundColor: Colors.green.shade100,
                                    title: Text("Logout"),
                                    content: Text(
                                      "Are you sure you want to logout?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInScreen(),
                                            ),
                                          );
                                        },
                                        child: Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("No"),
                                      ),
                                    ],
                                  );

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },

                                icon: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.yellow[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                        bottom: 25,
                        right: 25,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _msg,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreenAccent[400],
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            _name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            _text,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.withOpacity(0.5),
                          Colors.green.withOpacity(0.1),
                        ],
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      25,
                      25,
                      25,
                      MediaQuery.of(context).padding.bottom + 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "How are you feeling today?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: emotions.map((emotion) {
                              return GestureDetector(
                                onTap: () {
                                  if (emotion['label'] != _status) {
                                    update_status(emotion['label']);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'You are already feeling ${emotion['label']}',
                                        ),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.blue,
                                      ),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: emotion['color'],
                                        child: Text(
                                          emotion['emoji'],
                                          style: TextStyle(
                                            fontSize:
                                                _status == emotion['label']
                                                ? 60
                                                : 36,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        emotion['label'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/mandy.png',
                                fit: BoxFit.contain,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.navigate(2); // Navigate to chat
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFA4F2C1),
                                        Color(0xFF5BE285),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.greenAccent.withOpacity(
                                          0.4,
                                        ),
                                        blurRadius: 20,
                                        spreadRadius: 1,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Chat with Mindy',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.auto_awesome,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
