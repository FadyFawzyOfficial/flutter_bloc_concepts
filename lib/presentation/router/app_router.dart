import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/second_sreen.dart';
import '../screens/third_screen.dart';

//* Here we will setup all the logic for navigating to all of our screens.
class AppRouter {
  //* The main idea here is that we want to create a function which takes in
  //* mainly the name of the route we want to generate and returns the generated
  //* screen accordingly.
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.name:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(
            title: 'HomeSreen',
            color: Colors.blueAccent,
          ),
        );
      case SecondScreen.name:
        return MaterialPageRoute(
          builder: (context) => const SecondScreen(
            title: 'SecondScreen',
            color: Colors.redAccent,
          ),
        );
      case ThirdScreen.name:
        return MaterialPageRoute(
          builder: (context) => const ThirdScreen(
            title: 'ThirdScreen',
            color: Colors.greenAccent,
          ),
        );
      default:
        return null;
    }
  }
}
