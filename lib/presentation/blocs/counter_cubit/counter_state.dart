part of 'counter_cubit.dart';

//** equatable
//* ayuda a poder comparar dos objetos
//* esto permite que cuando los objetos sean iguales no se reconstruya el widget

//* aqui se definira como luce el estado y las variables que contendra
//* se instalo el paquete equatable de la pub dev equatable
class CounterState extends Equatable {
  //* estas variables son las que semanejaran con el state de cubit,
  final int counter;
  final int transactionCount;

  const CounterState({this.counter = 0, this.transactionCount = 0});

  //* funcion que se utiliza para cambiar el estado es decir emitir un nuevo estado

  copyWith({int? counter, int? transactionCount}) => CounterState(
      counter: counter ?? this.counter,
      transactionCount: transactionCount ?? this.transactionCount);

  //* con esta funcion comparo que si counter y transactionCount son iguales
  //* a pesar que se emita un nuevo estado noconstruye nada
  //* mejorando la eficiencia
  @override
  List<Object> get props => [counter, transactionCount];
}
