import 'counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  CounterPage();
  @override
  Widget build(BuildContext context) {
    final counterBloc = Provider.of<CounterBloc>(context);
    return new Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              StreamBuilder(
                initialData: 0,
                stream: counterBloc.count,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          verticalDirection: VerticalDirection.up, // childrenの先頭を下に配置
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                counterBloc.changeCountAction.add(false);
              },
              tooltip: 'Declement',
              child: Icon(Icons.remove),
            ),
            Container( // 余白のためContainerでラップ
              margin: EdgeInsets.only(bottom: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  counterBloc.changeCountAction.add(true);
                },
                tooltip: 'Increment',
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.add),
              ),
            ),
          ],
        )
    );
  }
}