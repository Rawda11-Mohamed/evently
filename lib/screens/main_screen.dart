import 'package:flutter/material.dart';
import 'search_events_screen.dart';
import '../screens/home_screen.dart';
import '../screens/search_events_screen.dart';
import '../widgets/bottom_nav_bar_item.dart';
import '../screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const MainScreen({super.key, required this.onThemeChanged});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(),
      SearchEventsScreen(),
      ProfileScreen(onThemeChanged: widget.onThemeChanged),
    ];
    return SafeArea(
      child: Scaffold(
        body: screens[currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedLabelStyle: TextStyle(color: Colors.white),
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,

          items: [
            BottomNavigationBarItem(
              icon: BottomNavBarItem(
                isSelected: currentIndex == 1 ? true : false,
                icon: Icon(Icons.home),
              ),
              label: 'home',
            ),

            BottomNavigationBarItem(
              icon: BottomNavBarItem(
                isSelected: currentIndex == 2 ? true : false,
                icon: Icon(Icons.favorite),
              ),
              label: 'favorite',
            ),

            BottomNavigationBarItem(
              icon: BottomNavBarItem(
                isSelected: currentIndex == 3 ? true : false,
                icon: Icon(Icons.person),
              ),
              label: 'person',
            ),
          ],
        ),
      ),
    );
  }
}
