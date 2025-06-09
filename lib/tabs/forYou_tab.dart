import 'package:feel_better_fixed/tabs/item_screens/films_screen.dart';
import 'package:feel_better_fixed/tabs/item_screens/music_screen.dart';
import 'package:feel_better_fixed/tabs/item_screens/novels_screen.dart';
import 'package:flutter/material.dart';

class ForyouTab extends StatefulWidget {
  const ForyouTab({super.key});

  @override
  State<ForyouTab> createState() => _ForyouTabState();
}

class _ForyouTabState extends State<ForyouTab> {
  final List<Map<String, dynamic>> recommendations = [
    {'title': '', 'image': 'assets/films.png', 'page': MoviesScreen()},
    {'title': '', 'image': 'assets/novels.png', 'page': NovelsScreen()},
    {'title': '', 'image': 'assets/music.png', 'page': MusicScreen()},
    {'title': '', 'image': 'assets/nature.png', 'page': MoviesScreen()},
    {'title': '', 'image': 'assets/articales.png', 'page': MoviesScreen()},
    // {'title': '', 'image': 'assets/channelling.png', 'page': MoviesScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: Container(
          color: Colors.green.withOpacity(0.2),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.012,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: screenWidth * 0.05,
                    backgroundImage: AssetImage('assets/profile.jpeg'),
                  ),
                  // Notification Icon
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Icon(
                      Icons.notifications_none,
                      color: Colors.orange[800],
                      size: screenWidth * 0.06,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.2),
                      Colors.green.withOpacity(0.05),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.06,
                    0,
                    screenWidth * 0.06,
                    media.padding.bottom + screenHeight * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'For you',
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Recommendation’s',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: Colors.green[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Icon(
                            Icons.auto_awesome,
                            color: Colors.green[800],
                            size: screenWidth * 0.05,
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: screenWidth * 0.04,
                        crossAxisSpacing: screenWidth * 0.04,
                        childAspectRatio: 1,
                        children: recommendations
                            .map(
                              (item) => _buildRecommendationCard(
                                item['title']!,
                                item['image']!,
                                screenWidth,
                                item['page'],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated Helper Widget with dynamic font sizing
  Widget _buildRecommendationCard(
    String title,
    String imagePath,
    double screenWidth,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () {
        // You can navigate to detailed screens here.

        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
