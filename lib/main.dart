import 'package:flutter/material.dart';

import 'presentation/router/app_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //! Generated Routing
  //* We need to create an instance of our AppRouter Class to pass the
  //* onGenerateRoute its function.
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      //* We delete the routes parameter completely since we don't need it anymore.
      //* Instead, we'll use the onGenerateRoute parameter, which takes in our
      //* onGererateRoute function inside our AppRouter Class.
      //! Pay attention because we need to pass the function as an argument and
      //! not as a result of it.
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
