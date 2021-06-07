import 'package:bloc/bloc.dart';
import 'package:hacker_news/src/bloc/counter_event.dart';
import 'package:hacker_news/src/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async*{

    if (event is IncrementEvent) {
      //9 bhanada mathi jana didaina.
      if(state.count>9) return;
      yield(CounterState(count: state.count + 1));
    }
    else if (event is DecrementEvent) {
      yield(CounterState(count: state.count - 1));
    }

  }

}
