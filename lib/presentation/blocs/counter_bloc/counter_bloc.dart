import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  //* con esto  super(const CounterState()) inicializamos el estado
  CounterBloc() : super(const CounterState()) {
    //* esto en un manejador del CounterEvent para usar los metodos que se definieron en esa clase
    //* y se esta mandando la referencia a la funcion _onCounterIncrease
    on<CounterIncreased>(_onCounterIncrease);

    //* esto en un manejador del CounterEvent para usar los metodos que se definieron en esa clase
    //* y se esta ejecutando sin mandar la referencia a otra función
    on<CounterReset>((event, emit) {
      emit(state.copyWith(counter: 0));
    });
  }

  void _onCounterIncrease(CounterIncreased event, Emitter<CounterState> emit) {
    emit(state.copyWith(
        counter: state.counter + event.value,
        transactionCount: state.transactionCount + 1));
  }

  //*Disparar eventos dentro del Bloc
  void increaseBy([int value = 1]) {
    add(CounterIncreased(value));
  }

  void reset([int value = 1]) {
    add(CounterReset());
  }
}
