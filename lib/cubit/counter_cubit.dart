import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

// Since the counter feature of the app we want to implement is really simple,
// We will start by creating a new Cubit called CounterCubit.
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());
}
