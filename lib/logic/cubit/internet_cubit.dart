import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';

part 'internet_state.dart';

//* We can notice that when the InternetCubit constructor gets called,
//* the first emitted Internet state down the stream will be InternetLoading.
//! 1st
//! So to recap, the purpose of this InternetCubit is to emit different Internet
//! Connection states based on what is written by the connectivity plus plugin.
class InternetCubit extends Cubit<InternetState> {
  //! 2nd
  //! Therefore, somehow we need to react to do something in response to the
  //! connectivity plus plugin.
  //! So we need to add a dependency of it into the InternetCubit class.
  final Connectivity connectivity;
  //! 3rd
  //! OK, since we need our InternetCubit to listen to the connectivity plus stream.
  //! First and foremost, we need to create a stream subscription so that we'll
  //! be able to subscribe to the specific stream.
  late StreamSubscription connectivityStreamSubscription;

  //! 4th
  //! Then we'll need to initialize this connectivity stream subscription inside
  //! the constructor by subscribing to the onConnectivityChange stream and then
  //! by listening to it.
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    //! 5th
    //! So to recap, every time a new connection is noticed by the connectivity
    //! plus plugin this onConnectivityChange stream will send the
    //! connectivityResult down the stream.
    //! Currently, our InternetCubit is just listening to the connectivityResults
    //! emitted by the plugin, but we also need to do something in response to them.
    //! We need to meet new Internet states accordingly to what the connectivity result is.
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      //! 6th
      //! So every time a connectivityResult is received down the stream
      //! will verify if it's of type connectivity.wifi, mobile or not,
      //! if it's of connectivityType.wifi will call the
      //! emitInternetConnected() function from inside the Cubit.
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectiionType.Wifi);
      }
      //! 7h
      //! In the mobile case will change the connection type to mobile.
      else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectiionType.Mobile);
      }
      //! 8th
      //! And finally, if the connectivityResult is of type ConnectivityResult.none
      //! will emit the InternetDisconnected state.
      else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }

      //! 9th
      //! Not that we don't need to meet the InternetLoading state
      //! since it will be automatically emitted when the InternetCubit is created.
    });
  }

  //! Because we created stream subscription hasn't been closed yet.
  //! We don't want you to be listening forever. So we'll close the subscription
  //! right when the block is closed.
  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  //! Now, we will create the specific Cubit methods which will emit the states
  //! we created previously in internet_state.dart file.

  //* the emitInternetConnected function will take a connection type as a
  //* parameter and will emit an InternetConnected state with the same
  //* connectionType so that we know whether it's the WiFi or mobile data
  //* we're connected to.
  void emitInternetConnected(ConnectiionType _connectionType) =>
      emit(InternetConnected(connectiionType: _connectionType));

  //* the emitInternetDisconnected function will emit an InternetDisconnected
  //* state accordingly.
  void emitInternetDisconnected() => emit(InternetDisconnected());
}
