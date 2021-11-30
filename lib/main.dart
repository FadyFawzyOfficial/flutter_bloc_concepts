import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/logic/cubit/internet_cubit.dart';

import 'logic/cubit/counter_cubit.dart';
import 'presentation/router/app_router.dart';

void main() => runApp(MyApp());

//* MyApp class does need to be a stateful widget anymore,
//* so we convert it back to a statelets widget.
class MyApp extends StatelessWidget {
  //! Generated Routing
  //* We need to create an instance of our AppRouter Class to pass the
  //* onGenerateRoute its function.
  final AppRouter _appRouter = AppRouter();
  //* We know that our connectivity plugin doesn't depend on anything,
  //* so we'll create it firstly.
  final Connectivity _connectivity = Connectivity();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          create: (context) => InternetCubit(
            connectivity: _connectivity,
          ),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
            internetCubit: BlocProvider.of<InternetCubit>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        //* We delete the routes parameter completely since we don't need it anymore.
        //* Instead, we'll use the onGenerateRoute parameter, which takes in our
        //* onGererateRoute function inside our AppRouter Class.
        //! Pay attention because we need to pass the function as an argument and
        //! not as a result of it.
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }

  //* We can also delete the dispose function since will create the instance of
  //* the Bloc inside the BlocProvider.
  //* Therefore, the block provider will automatically close it.AboutDialog
}
