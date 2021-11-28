import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit.dart';

import '../screens/home_screen.dart';
import '../screens/second_sreen.dart';
import '../screens/third_screen.dart';

//* Here we will setup all the logic for navigating to all of our screens.
class AppRouter {
  //* The main idea here is that we want to create a function which takes in
  //* mainly the name of the route we want to generate and returns the generated
  //* screen accordingly.

  //! Generated Routing
  //! 1st
  //* So again, we set up the navigation feature, but what we want now is to know
  //? how we can provide an existing instatnce of a Bloc\Cubit to each of our
  //? screens?
  //! Creating a new instance for each screen is agin not an option.
  //* So instead we will create the unique Cubit instance right here (at the top),
  //* as we did with the Named Routing.
  final CounterCubit _counterCubit = CounterCubit();

  //! 2nd
  //* Then, since we need to provide the existing instance of CounterCubit we
  //* created to all of our screens, we need to wrap them inside a
  //* Bloc.provider.value() widget again.
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.name:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _counterCubit,
            child: const HomeScreen(
              title: 'HomeSreen',
              color: Colors.blueAccent,
            ),
          ),
        );
      case SecondScreen.name:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _counterCubit,
            child: const SecondScreen(
              title: 'SecondScreen',
              color: Colors.redAccent,
            ),
          ),
        );
      case ThirdScreen.name:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _counterCubit,
            child: const ThirdScreen(
              title: 'ThirdScreen',
              color: Colors.greenAccent,
            ),
          ),
        );
      default:
        return null;
    }
  }

  //! 3rd
  //* Since we created the instance of CounterCubit manully will also need to
  //* manually close it.
  void dispose() => _counterCubit.close();
}
