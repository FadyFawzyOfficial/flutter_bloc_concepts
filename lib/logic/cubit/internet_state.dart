part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

//* By default, every Bloc or Cubit comes with an initial state.
//* This state is emitted when the Bloc or Cubit instance gets created.
//* We know that will instantiate the InternetCubit when the application starts.
//* and since the plug in may take some time to detect whether the phone is
//* connected to WiFi or mobile or to nothing, we'll need to show a loading
//* animation in order to let the user know that something is actually happening
//* in the background.
//* So instead of showing an InternetInitial state will show an Internet Loading
//* State.
//! So instead of showing an InternetInitial state will show an InternetLoading
//! state.
class InternetLoading extends InternetState {}

//* we have decided to have an Internet connected and internet disconnected state.
//* We know that our phone can be connected to the Internet by using either
//* Wi-Fi or mobile data.
//* Therefore, the type of connection needs to be specified inside the state.
//* This can be done by creating a final variable of the connection type will
//* assign it as a required parameter inside the constructor.
//* So whenever the Internet Cubitt will meet, a new interconnected state will
//* have to mention the type of connection we're using, whether it's Wi-Fi or mobile.
class InternetConnected extends InternetState {
  final ConnectiionType connectiionType;

  const InternetConnected({required this.connectiionType});

  @override
  String toString() => 'InternetConnected(connectiionType: $connectiionType)';
}

class InternetDisconnected extends InternetState {}
