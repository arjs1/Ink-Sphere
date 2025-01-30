import 'package:flutter/material.dart';
import 'package:ink_sphere/pages/CreateBloggPage/create_blogg_page.dart';
import 'package:ink_sphere/pages/DiscoverPage/discover_page.dart';
import 'package:ink_sphere/pages/FollowBloggPage/follow_blogg_page.dart';
import 'package:ink_sphere/pages/ProfilePage/profile_page.dart';
import 'package:ink_sphere/pages/SearchPage/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> page = const [
    DiscoverPage(),
    FollowBloggPage(),
    CreateBloggPage(),
    SearchPage(),
    ProfilePage(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: page[_currentIndex],
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.primary,
          height: 120,
          child: BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: Theme.of(context).colorScheme.primary,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey.shade400,
              selectedItemColor: Colors.white,
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore), label: 'Discover'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people_alt), label: 'For You'),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ]),
        ));
  }
}
