import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/counter_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // As you can see the top of the widgets tree is MaterialApp widget.
    // There is where the tree starts from in most of the flutter apps.
    // So inorder to make our CounterCubit available throughout the entire tree
    // over app, we must create our BlocProvider with it at our MaterialApp level.
    return BlocProvider<CounterCubit>(
      // All we need to do is to take the current context and return a
      // CounterCubit instatnce.
      //* So what we did now is we told Flutter to create a single & unique
      //* instance of the CounterCubit and make it available to the subtree
      //* below MaterialApp widget.
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // 1st: To understand the BlocListener easily, do the following:
      // Every time the user presses the plus or minus buttons, there should
      // be a SnackBar showing in the bottom part of the screen saying
      // incremented or decremented depending on which buttom was pressed
      //? Can you guess how we are going to do that?
      // Let's start with the beginning ...
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          //* Based on our state.wasIncremented attribute, we will display a
          //* SnackBar accordingly to whether the counter value of our
          //* Counter State was incremented (state.wasIncremented == true)
          //* or decremented (state.wasIncremented == false).
          if (state.wasIncremented!) {
            Scaffold.of(context).showSnackBar(
              const SnackBar(
                content: Text('Incremented'),
                duration: Duration(microseconds: 500),
              ),
            );
          } else if (!state.wasIncremented!) {
            Scaffold.of(context).showSnackBar(
              const SnackBar(
                content: Text('Decremented'),
                duration: Duration(microseconds: 500),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You have pushed the button this many times:',
              ),
              //? How do we receive the new state inside the UI?
              //? How do we rebuild the specific Text widget which prints out the
              //? counter value (counterValue)?
              //* The counter value of the app should be printed right inside this
              //* Text widget.
              //* All we have to do is to wrap this specific Text widget into BlocBuilder.
              BlocBuilder<CounterCubit, CounterState>(
                // Now, Into the builder function, for every new emitted counter state
                // (CounterState), the Text widget will show a new value.
                // The value can be accessed by calling 'state.counterValue'.
                builder: (context, state) {
                  // I can check whether the state's counterValue is negative
                  // and print a negative text widget.
                  if (state.counterValue < 0) {
                    return Text(
                      'BRR, NEGATIVE ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                  // I can check if the counterValue is even and print YAY
                  else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAAY ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                  // Or I can check if the counterValue is equal to five and print
                  // HMM, NUMBER 5
                  else if (state.counterValue == 5) {
                    return Text(
                      'HMM, NUMBER 5 ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else {
                    return Text(
                      '${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              // The 2 FloatingActionButton which are supposed to increment or
              // decrement the counter.
              // Remember that for every interaction an user makes with the app,
              // there should be a state emerging from the app letting the user
              // know what's going on?!
              // Having that in mind, we conclude that for every tap of either of
              // these 2 buttons, there should be a new counter state (CounterState),
              // perhaps counter value (counterValue) shown on the screen.
              // To do that, we need to call the increment or decrement functions
              // on the cubit instance.
              //? But, How do we access the cubit instance?!
              //* Every time we press one of these buttons, the cubit, the increment
              //* or decrement function will be called adding or subtracting 1 to
              //* the current state.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 2nd: So what happens when we press either of these 2 buttons,
                  // The increment or decrement function from inside the cubit,
                  // it gets called
                  //? What do these functions do?
                  FloatingActionButton(
                    child: const Icon(Icons.remove_rounded),
                    tooltip: 'Decrement',
                    heroTag: Text(widget.title),
                    onPressed: () {
                      //* Either by calling
                      BlocProvider.of<CounterCubit>(context).decrement();
                      //* or with in
                      // context.bloc<CounterCubit>().decrement();
                    },
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.add_rounded),
                    tooltip: 'Increment',
                    heroTag: Text('${widget.title} #2'),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                      // context.bloc<CounterCubit>().increment();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
