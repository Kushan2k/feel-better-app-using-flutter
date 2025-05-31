import 'package:feel_better_fixed/tabs/chat_tab.dart';
import 'package:feel_better_fixed/tabs/forYou_tab.dart';
import 'package:feel_better_fixed/tabs/home_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  List<Widget> pages = [
    HomeTab(),
    ForyouTab(),
    ChatTab(),
    Center(child: Text('History')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int i) {
          setState(() {
            index = i;
          });
        },
        backgroundColor: Color(0XE8FAEA),
        selectedIndex: index,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF65D080),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.home, size: 35, color: Colors.white),
              ),
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF65D080),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.thumb_up_off_alt_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            icon: Icon(Icons.thumb_up_alt_outlined),
            label: 'For You',
          ),
          NavigationDestination(
            selectedIcon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF65D080),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.message, size: 35, color: Colors.white),
              ),
            ),
            icon: Icon(Icons.messenger_outline),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF65D080),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.history_edu_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            icon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2),
            selectedIcon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF65D080),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.person_2_outlined,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
