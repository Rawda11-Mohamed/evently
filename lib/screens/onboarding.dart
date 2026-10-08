import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../screens/main_screen.dart';
import '../widgets/custom_elevated_button.dart';
import '../screens/signup_screen.dart';

class Onboarding extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const Onboarding({super.key, required this.onThemeChanged});
  @override
  State<Onboarding> createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  PageController pageController = PageController();
  List<Map<String, String>> pages = [
    {
      'image': 'assets/images/being-creative.png',
      'title': 'Personalize Your Experience',
      'describtion':
          'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
    },
    {
      'image': 'assets/images/being-creative (1).png',
      'title': 'Find Events That Inspire You',
      'describtion':
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    },
    {
      'image': 'assets/images/being-creative (2).png',
      'title': 'Effortless Event Planning',
      'describtion':
          'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters , creating an unforgettable experience for you and your guests.',
    },
    {
      'image': 'assets/images/being-creative (3).png',
      'title': 'Connect with Friends & Share Moments',
      'describtion':
          'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/Evently.png', width: 290, height: 130),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 5,
                effect: WormEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  dotColor: Colors.grey,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: pages.length,
                controller: pageController,
                onPageChanged: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Image.asset(pages[index]['image']!)),
                      SizedBox(height: 40),
                      Text(
                        pages[index]['title']!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            pages[index]['describtion'] ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            CustomElevatedButton(
              text:
                  (currentIndex == pages.length - 1) || (currentIndex == 0)
                      ? 'Get Started'
                      : (currentIndex == 0 ? "Let's Start" : 'Next'),

              onPressed:
                  currentIndex == pages.length - 1
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignupScreen(
                                onThemeChanged: widget.onThemeChanged,
                              );
                            },
                          ),
                        );
                      }
                      : () {
                        pageController.nextPage(
                          curve: Curves.bounceIn,
                          duration: Duration(milliseconds: 300),
                        );
                      },
            ),
          ],
        ),
      ),
    );
  }
}
