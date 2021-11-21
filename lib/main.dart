import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/counter_cubit.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  //* Now, whenever we will compare CounterState, Dart will compare them
  //* attributes by attributes inorder to see whether they're equal or not
  final CounterState counterStateA = CounterState(counterValue: 1);
  final CounterState counterStateB = CounterState(counterValue: 1);
  //! This should return 'true' now.
  print(counterStateA == counterStateB);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // As you can see the top of the widgets tree is MaterialApp widget.
    // There is where the tree starts from in most of the flutter apps.
    // So inorder to make our CounterCubit available throughout the entire tree
    // over app, we must create our BlocProvider with it at our MaterialApp level.
    // All we need to do is to take the current context and return a
    // CounterCubit instatnce.
    //* So what we did now is we told Flutter to create a single & unique
    //* instance of the CounterCubit and make it available to the subtree
    //* below MaterialApp widget.
    //! To Learn the BLoC Access Concept we will move the BlocProvider to be the
    //! parent widget of HomeScreen (Widget) instead of MaterialApp (Widget).
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      //! Anonumous Routing
      // Anonumous Routing is what we have been doing so far in our CounterApp
      // So by default: we provide only the name of the HomeScreen class to
      // the home paremeter inside the MaterialApp
      //* Currently we provide a CounterCubit locally to our HomeScreen,
      //* therefore to all of its childern widgets.
      home: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: const HomeScreen(
          title: 'Flutter Demo Home Page',
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
