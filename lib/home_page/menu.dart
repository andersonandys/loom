import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vines/movie/home_screenmovie.dart';
import 'package:vines/movie/profiluser/profiluserScreen.dart';
import 'package:vines/movie/search/searchMovieScreen.dart';
import 'package:vines/movie/viewvideo/viewvideoScreen.dart';

class MenuApp extends StatefulWidget {
  ///
  const MenuApp({Key? key}) : super(key: key);

  @override
  State<MenuApp> createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  int _selectedIndex = 0;
  Widget _selectedWidget = HomeScreenmovie();

  void changeTab(index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        _selectedWidget = const HomeScreenmovie();
      } else if (_selectedIndex == 1) {
        _selectedWidget = const SearchMovieScreen();
      } else if (_selectedIndex == 2) {
        _selectedWidget = const ViewvideoScreen();
      } else if (_selectedIndex == 3) {
        _selectedWidget = const ProfiluserScreen();
      } else if (_selectedIndex == 4) {
        _selectedWidget = const ProfiluserScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedWidget,
      // extendBody: true,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (i) => changeTab(i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(
              IconsaxOutline.home,
              size: 25,
            ),
            title: const Text(
              "Accueil",
              style: TextStyle(fontSize: 17),
            ),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(
              IconsaxOutline.search_normal,
              size: 25,
            ),
            title: const Text(
              "Recherche",
              style: TextStyle(fontSize: 17),
            ),
            selectedColor: Colors.purple,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(
              IconsaxOutline.play,
              size: 25,
            ),
            title: const Text(
              "Mes vidéos",
              style: TextStyle(fontSize: 17),
            ),
            selectedColor: Colors.purple,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(
              IconsaxOutline.profile_circle,
              size: 30,
            ),
            title: const Text(
              "profil",
              style: TextStyle(fontSize: 17),
            ),
            selectedColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
