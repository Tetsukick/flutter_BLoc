import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CounterBloc {
  // input
  final _actionController = BehaviorSubject<bool>();
  Sink<void> get changeCountAction => _actionController.sink;

  //output
  final _countController = BehaviorSubject<int>();
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