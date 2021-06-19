import 'dart:async';

import 'package:bloc_tutorial/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  StreamController<CounterEvent> _counterEventController =
      StreamController<CounterEvent>();
  Sink<CounterEvent> get eventSink => _counterEventController.sink;
  Stream<CounterEvent> get _eventStream => _counterEventController.stream;

  StreamController<int> _counterStateController = StreamController<int>();
  Sink<int> get _incounter => _counterStateController.sink;
  Stream<int> get outputStream => _counterStateController.stream;

  CounterBloc() {
    _eventStream.listen(_mapEventToState);
  }

  _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    }
    if (event is DecrementEvent) {
      _counter--;
    }
    _incounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
