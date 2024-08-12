

import 'package:anim_indexed_demo/anim_indexed/animated_indexed_stack.dart';
import 'package:anim_indexed_demo/anim_indexed/build_page_transitions_theme.dart';
import 'package:anim_indexed_demo/business.dart';
import 'package:anim_indexed_demo/education.dart';
import 'package:anim_indexed_demo/home.dart';
import 'package:anim_indexed_demo/technology.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedIndexedStack(
          index: _pageIndex,
          // if we are using PageTransionThemes
          // then we have to use the 
          // buildPageTransitionsTheme method
          transitionBuilder: (child,animation,secondaryAnimation)=> SharedAxisTransition(
    animation: animation,
    secondaryAnimation: secondaryAnimation,
   transitionType: SharedAxisTransitionType.horizontal,
   child: child,
  ),
            children: const <Widget>[
            Home(),
            Business(),
            Technology(),
            Education(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
              label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
              label: 'Technology',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
              label: 'Education',
          ),
        ],
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(
                () {
              _pageIndex = index;
            },
          );
        },
      ),
    );
  }
}