import 'package:flutter/material.dart';
import 'login_screen.dart'; // Assuming you have a login screen

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  // List of onboarding images and text
  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding1.jpg",
      "title": "Welcome to Recipe Helper",
      "subtitle": "Get meal suggestions based on your ingredients."
    },
    {
      "image": "assets/images/onboarding2.jpeg",
      "title": "Track Your Ingredients",
      "subtitle": "Add your available ingredients and see what you can cook."
    },
    {
      "image": "assets/images/onboarding3.jpg",
      "title": "Easy Recipes",
      "subtitle": "Discover recipes and cook delicious meals effortlessly."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // Image fills width & proportional height
                    Container(
                      width: size.width,
                      height: size.height * 0.6,
                      child: Image.asset(
                        onboardingData[index]["image"]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Title
                    Text(
                      onboardingData[index]["title"]!,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        onboardingData[index]["subtitle"]!,
                        style: TextStyle(fontSize: 16, color: Colors.brown[600]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(onboardingData.length, (index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == index ? 12 : 8,
                height: currentIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  color:
                      currentIndex == index ? Colors.brown[800] : Colors.brown[300],
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          SizedBox(height: 20),

          // Next / Get Started button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[700],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                if (currentIndex < onboardingData.length - 1) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                } else {
                  // Go to login or main app
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              child: Text(
                currentIndex == onboardingData.length - 1
                    ? "Get Started"
                    : "Next",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
