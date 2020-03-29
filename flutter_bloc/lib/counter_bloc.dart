import 'dart:async';

class CounterBloc {
  // input
  final _actionController = StreamController<bool>();
  Sink<void> get changeCountAction => _actionController.sink;

  //output
  final _countController = StreamController<int>();
  Stream<int> get count => _countController.stream;

  int _count = 0;

  CounterBloc() {
    _actionController.stream.listen((isPlus) {
      if (isPlus) {
        _count++;
      } else {
        _count--;
      }
      _countController.sink.add(_count);
    });
  }

  void dispose() {
    _actionController.close();
    _countController.close();
  }
}