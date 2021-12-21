import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/cubit/counter_cubit.dart';
import '../../logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  static const String name = '/';

  final String title;
  final Color color;

  // I have also modified the HomeScreen Class a little bit so that it will take
  // a title and a color as parameters in order to make it stand out compared
  // to the next screen we will create
  const HomeScreen({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//* Currently our CounterApp is dependent on the Network state.
// But in order to test if a specific widget will rebuild based on at least one
// of the two separate states, we need to make the Cubits independent again
// so we will delete the BlocListener which caused the counter to to increment
// and decrement based on whether the InternetCubit was connected to WiFi or mobile,
// then will uncommented the lines of code containing the plus and minus
// floating buttons that caused the CounterCubit to manually increment or decrement.
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<InternetCubit, InternetState>(
              builder: (internetCubitBuilderContext, state) {
                if (state is InternetConnected &&
                    state.connectiionType == ConnectiionType.Wifi) {
                  return Text(
                    'Wi-Fi',
                    style: Theme.of(internetCubitBuilderContext)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.green),
                  );
                } else if (state is InternetConnected &&
                    state.connectiionType == ConnectiionType.Mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(internetCubitBuilderContext)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.red),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(internetCubitBuilderContext)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.grey),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            //* BlocConsumer is a widget that combines both BlocListener &
            //* BlocConsumer into a single widget.
            // So instead of writing BlocListener on top of BlocBuilder as we did
            // in our example, actually we can refactor the code by writing both
            // of them inside the BlocComnsumer widget.
            //* The code is now more readable and easier to maintain and the
            //* application works prefect.
            BlocConsumer<CounterCubit, CounterState>(
              listener: (counterCubitListenerContext, state) {
                //* Based on our state.wasIncremented attribute, we will display a
                //* SnackBar accordingly to whether the counter value of our
                //* Counter State was incremented (state.wasIncremented == true)
                //* or decremented (state.wasIncremented == false).
                if (state.wasIncremented!) {
                  Scaffold.of(counterCubitListenerContext).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented'),
                      duration: Duration(microseconds: 500),
                    ),
                  );
                } else if (!state.wasIncremented!) {
                  Scaffold.of(counterCubitListenerContext).showSnackBar(
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
              builder: (counterCubitBuilderContext, state) {
                // I can check whether the state's counterValue is negative
                // and print a negative text widget.
                if (state.counterValue < 0) {
                  return Text(
                    'BRR, NEGATIVE ${state.counterValue}',
                    style: Theme.of(counterCubitBuilderContext)
                        .textTheme
                        .headline4,
                  );
                }
                // I can check if the counterValue is even and print YAY
                else if (state.counterValue % 2 == 0) {
                  return Text(
                    'YAAY ${state.counterValue}',
                    style: Theme.of(counterCubitBuilderContext)
                        .textTheme
                        .headline4,
                  );
                }
                // Or I can check if the counterValue is equal to five and print
                // HMM, NUMBER 5
                else if (state.counterValue == 5) {
                  return Text(
                    'HMM, NUMBER 5 ${state.counterValue}',
                    style: Theme.of(counterCubitBuilderContext)
                        .textTheme
                        .headline4,
                  );
                } else {
                  return Text(
                    '${state.counterValue}',
                    style: Theme.of(counterCubitBuilderContext)
                        .textTheme
                        .headline4,
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            //! context.watch()
            //? In order to demonstrate How context.watch() works?
            //! We will have to create a Widget which will rebuild whenever at
            //! least one of these two Cubits emits new states.
            //! We have to wrap the Widget with the Builder widget so that we can
            //! access to its closest context (Text has annonymous context) above it,
            Builder(
              builder: (BuildContext context) {
                //* All we need to do is to watch that state for each of the two
                //* cubits we're interested in, then use them appropriately to
                //* return reserve Text widget which will display the current
                //* counter value and the current state of the Internet Connection.
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;
                late final String internetStatus;
                if (internetState is InternetConnected &&
                    internetState.connectiionType == ConnectiionType.Mobile) {
                  internetStatus = 'Mobile';
                } else if (internetState is InternetConnected &&
                    internetState.connectiionType == ConnectiionType.Wifi) {
                  internetStatus = 'Wifi';
                } else {
                  internetStatus = 'Disconnected';
                }
                //! This Text widget rebuilds either by changing the counter
                //! value using the floting buttons or by changing the internet
                //! connection status (Wifi, Mobile or Disconnected)
                return Text(
                  'Counter: ${counterState.counterValue} Internet: $internetStatus',
                  style: Theme.of(context).textTheme.headline6,
                );
              },
            ),
            const SizedBox(height: 24),
            //! context.select()
            //* Again, to test this (context.select), all we have to do is to
            //* wrap a Text widget inside a Builder widget to access its closer
            //* BuildContext and then retrieve the new counter value inside the
            //* variable while also updating and rebuilding the Builder widget.
            //! Whenever the current counter value is different from the
            //! previous counter value context.select returns the new value
            //! and rebuilds the Builder widget.
            Builder(
              builder: (context) {
                final counterValue = context.select(
                    (CounterCubit counterCubit) =>
                        counterCubit.state.counterValue);
                return Text(
                  'Counter: $counterValue',
                  style: Theme.of(context).textTheme.headline6,
                );
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
                    // context.read<CounterCubit>().decrement();
                  },
                ),
                FloatingActionButton(
                  backgroundColor: widget.color,
                  child: const Icon(Icons.add_rounded),
                  tooltip: 'Increment',
                  heroTag: Text('${widget.title} #2'),
                  onPressed: () {
                    //! context.read
                    //* is a way to read/access a provided instance Bloc/Cubit
                    //* indise the widget tree which won't rebuild the widget.
                    //! Should be called only WHEN you need it, and only WHERE
                    //! you need it.
                    context.read<CounterCubit>().increment();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Builder(
              builder: (builderContext) {
                return MaterialButton(
                  color: Colors.redAccent,
                  child: const Text('Go to the Second Screen'),
                  //! Named Routing
                  //* The passed context is the BuildContext of the MaterialButton
                  //* Which is annonymous BuildContext which we can't access it.
                  //* So we cannot mention it inside the navigator, that of line of code.
                  //? But can we transform an anonymous context of a widget into a normal, accessible one?
                  //! Yes, we can.
                  //! by wraping the MaterialButton inside the Builder widget
                  //! and specify the name of builderContext for the BuildContext
                  //! instance in which the widget should be created.
                  //* Now we can pass the builderContext to the navigator.of(builderContext).
                  onPressed: () =>
                      Navigator.of(builderContext).pushNamed('/second'),
                );
              },
            ),
            // const SizedBox(height: 24),
            MaterialButton(
              color: Colors.greenAccent,
              child: const Text('Go to the Third Screen'),
              //! Named Routing
              //* the 2nd scenario, when we want to start searching for the
              //* Navigator widget from inside, the context of the HomeScreen.
              //* We will need to pass the homeScreenContext instance to the
              //* Navigator.of(homeScreenContext) line of code.
              onPressed: () =>
                  Navigator.of(homeScreenContext).pushNamed('/third'),
            ),
          ],
        ),
      ),
    );
  }
}
