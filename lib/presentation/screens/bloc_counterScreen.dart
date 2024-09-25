import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //*envolviedo el widget en un BlockProvider para poder terner acceso al provider
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const _BlocCounterView(),
    );
  }
}

class _BlocCounterView extends StatelessWidget {
  const _BlocCounterView();

  //*cuando se pone el parametro entre [] significa que es opcional
  void increaseCounterBy(BuildContext context, [int value = 1]) {
    //*llamando el metodo desde el event
    // context.read<CounterBloc>().add(CounterIncreased(value));

    //*llamando el metodo desde el bloc
    context.read<CounterBloc>().increaseBy(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //*recontrullendo el state con BlocBuilder
        title: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text('Bloc counter: ${state.transactionCount}');
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                //*llamando el metodo desde el event
                //context.read<CounterBloc>().add(CounterReset());

                //*llamando el metodo desde el bloc
                context.read<CounterBloc>().reset();
              },
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: Center(
          //*recontrullendo el state con context.select
          child: context.select((CounterBloc counterBloc) =>
              Text('Counter value: ${counterBloc.state.counter}'))),
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
