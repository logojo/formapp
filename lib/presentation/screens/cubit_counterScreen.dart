import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //* Envuelo el widget en un BlocProvider para tener acceso en todo este widget al state
    //* si envuelvo con BlocProvider en el main a toda la aplicación toda esta tendra acceso al state
    return BlocProvider(
        create: (_) => CounterCubit(), child: const _CubitCouterView());
  }
}

class _CubitCouterView extends StatelessWidget {
  const _CubitCouterView();

  void increaseCounterBy(BuildContext context, [int value = 1]) {
    context.read<CounterCubit>().increaseBy(value);
  }

  @override
  Widget build(BuildContext context) {
    //*otra manera de acceder al state del provider
    //final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        //* context.select me permite obtener todo el cubit
        //* y es identico a envolver con un BlocBuilder
        //* con esto se evita acceder de esta manera "final counterState = context.watch<CounterCubit>().state;"
        //*y es mas eficiente
        title: context.select((CounterCubit value) {
          return Text('cubit counter ${value.state.transactionCount}');
        }),

        actions: [
          IconButton(
              onPressed: () => context.read<CounterCubit>().reset(),
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: Center(
        //* al envolver en un BlocBuilder un widget solo este sera reconstruido al cambiar el state todo lo demas queda igual
        //* y esto es muy eficiente
        child: BlocBuilder<CounterCubit, CounterState>(
          //* esto le indica flutter que solo se reconstruya el widget cuando se cumpla esa condición
          //*pero se puede hacer de diferente manera
          //buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            return Text('Counter value: ${state.counter}');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => increaseCounterBy(context, 3),
            //*se usa eso para identificar a cada uno de los botones
            //*solo se usa cuando se tiene más de uno
            heroTag: '1',
            child: const Text('+3'),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () => increaseCounterBy(context, 2),
            heroTag: '2',
            child: const Text('+2'),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () => increaseCounterBy(context),
            heroTag: '3',
            child: const Text('+1'),
          )
        ],
      ),
    );
  }
}
