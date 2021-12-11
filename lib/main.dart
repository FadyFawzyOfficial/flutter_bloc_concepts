import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/internet_cubit.dart';
import 'presentation/router/app_router.dart';

void main() => runApp(
      MyApp(
        appRouter: AppRouter(),
        connectivity: Connectivity(),
      ),
    );

//* MyApp class does need to be a stateful widget anymore,
//* so we convert it back to a statelets widget.
class MyApp extends StatelessWidget {
  //! Architecture Tip #2: (Good Practice)
  //! When we want to create a Standalone instance which is an instance that
  //! doesn't depend on anything is to create it at the top inside the main
  //! function and then inject it into the app. In our case, within MyApp class.
  //! This way, our dependent Cubits, Blocs or Repositories can use their
  //! specific methods like BlocProvider, RepositoryProvider to create and also
  //! inject themselves into the rest of the app accordingly while also having
  //! access to the required dependencies.
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  //! BuildContexts Concept
  //* I rename them (BuildContext parameter) this way so that you will see
  //* better that they are completely different. When you fully understand this,
  //* you will find it easier to name all of them 'context' since you'll know
  //* which 'context' goes where immediately.
  @override
  Widget build(BuildContext myAppContext) {
    //! All we need to do now is to wrap the MaterialApp inside the BlocProvider
    //! and create the only instance of the CounterCubit to be provided globally
    //! to all of our screens.

    //! Bloc Communication
    //* All we need to do now is to provide both our InternetCubit and
    //* CounterCubit globally to our pages. But the reality is that the
    //* CounterCubit is dependent on the InternetCubit and the InternetCubit
    //* is also dependent on the connectivity plus plugin.
    //? So what do we do in this case?
    //! What I usually do is instantiate the objects by following the order from
    //! the least dependent one to the most dependent one.
    //* Now, all we need to do is to adapt to our needs.
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (internetCubitContext) => InternetCubit(
            connectivity: connectivity,
          ),
        ),
        BlocProvider<CounterCubit>(
          create: (counterCubitContext) => CounterCubit(),
        ),
      ],
      //* So if you are seeing the MaterialApp here alone (Without BuildContext),
      //* this doesn't mean it was built without any context.
      //* It has an anonymous BuildContext, but it's still a BuildContext like
      //* every other widget, and will be placed correctly inside the widget.
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        //* We delete the routes parameter completely since we don't need it anymore.
        //* Instead, we'll use the onGenerateRoute parameter, which takes in our
        //* onGererateRoute function inside our AppRouter Class.
        //! Pay attention because we need to pass the function as an argument and
        //! not as a result of it.
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }

  //* We can also delete the dispose function since will create the instance of
  //* the Bloc inside the BlocProvider.
  //* Therefore, the block provider will automatically close it.AboutDialog
}
