import 'counter_bloc.dart';
import 'search_bloc.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_page.dart';
import 'search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            Provider<CounterBloc>(
              create: (context) => CounterBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
            Provider<SearchBloc>(
              create: (context) => SearchBloc(),
              dispose: (context, bloc) => bloc.dispose(),
            ),
          ],
          child: MyHomePage(title: 'Flutter BLoC Counter'),
        )
    );
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
            SearchPage(),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
