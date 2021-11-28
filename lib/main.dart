import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //! All we need to do now is to wrap the MaterialApp inside the BlocProvider
    //! and create the only instance of the CounterCubit to be provided globally
    //! to all of our screens.
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
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
