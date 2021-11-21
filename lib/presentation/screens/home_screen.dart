import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/presentation/screens/third_screen.dart';

import '../../logic/cubit/counter_cubit.dart';
import 'second_sreen.dart';

class HomeScreen extends StatefulWidget {
  // I have also modified the HomeScreen Class a little bit so that it will take
  // a title and a color as parameters in order to make it stand out compared
  // to the next screen we will create
  const HomeScreen({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            //* BlocConsumer is a widget that combines both BlocListener &
            //* BlocConsumer into a single widget.
            // So instead of writing BlocListener on top of BlocBuilder as we did
            // in our example, actually we can refactor the code by writing both
            // of them inside the BlocComnsumer widget.
            //* The code is now more readable and easier to maintain and the
            //* application works prefect.
            BlocConsumer<CounterCubit, CounterState>(
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
                  backgroundColor: widget.color,
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
                  backgroundColor: widget.color,
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
            const SizedBox(height: 24),
            MaterialButton(
              color: widget.color,
              child: const Text('Go to the Second Screen'),
              //! Named Routing
              onPressed: () => Navigator.of(context).pushNamed('/second'),
            ),
            const SizedBox(height: 24),
            MaterialButton(
              color: widget.color,
              child: const Text('Go to the Third Screen'),
              //! Named Routing
              onPressed: () => Navigator.of(context).pushNamed('/third'),
            ),
          ],
        ),
      ),
    );
  }
}
