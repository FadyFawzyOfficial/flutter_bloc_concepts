import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  //? If you've ever been curious on how and most importantly, when our Cubits
  //? get created inside our app?
  //! Now it's the time to learn one important key factor.
  @override
  void onCreate(BlocBase bloc) {
    //* So let's print whatever Cubits gets created here and observe a really
    //* important difference.
    print(bloc);
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  // Here, we can print the change exactly as we previously do inside the
  // CounterCubit (in pervious git commits)
  //* This onChange will react globally right now to every change from every Cubit.
  //! Therefore, the 'change' parameter can be a type of CounterState, InternetState
  //! or SettingsState. So, We need to make sure that every one of them have their
  //! toString method overridden so that we can easily print their values.
  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
  }
}
