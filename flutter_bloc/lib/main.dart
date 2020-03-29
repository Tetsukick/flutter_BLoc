import 'counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Provider<CounterBloc>(
          create: (context) => CounterBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: MyHomePage(title: 'Flutter BLoC Counter'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            tabs: <Widget>[
              new Tab(
                text: "Count",
              ),
              new Tab(
                text: "Search",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget> [
            CounterPage(),
            NewPage('Search'),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  final String title;
  NewPage(this.title);
  @override
  Widget build(BuildContext buildContext) {
    return new Scaffold(
        body: new Center(
          child: new Text(title),
        )
    );
  }
}
