import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_bloc.dart';

class SearchPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController queryInputController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: '検索キーワード',
                              ),
                              controller: queryInputController,
                            ))),
                    RaisedButton(
                        child: const Text('検索'),
                        onPressed: () =>
                            searchBloc.changeQuery.add(queryInputController.text)),
                  ])),
              StreamBuilder(
                  stream: searchBloc.result,
                  builder: (context, snapshot) {
                    print(snapshot);
                    print(snapshot.hasError);
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      // snapshot.error を使ったWidgetを返す
                      // snapshot は AsyncSnapshot<T> で
                    }
                    if (snapshot.data != null) {
                      return Container(height: 200, child: SingleChildScrollView(child: Text(snapshot.data.toString()),),);
                      return ListView(
                        children: ListTile.divideTiles(
                            context: context,
                            tiles: snapshot.data.map((result) {
                              print(result);
                              return ListTile(
                                title: Text(result['full_name']),
//                                subtitle: new Row(
//                                  mainAxisSize: MainAxisSize.max,
//                                  children: <Widget>[
//                                    Flexible(
//                                        child: Text(
//                                            'Major: ${beacon.major}\nMinor: ${beacon.minor}',
//                                            style: TextStyle(fontSize: 13.0)),
//                                        flex: 1,
//                                        fit: FlexFit.tight),
//                                    Flexible(
//                                        child: Text(
//                                            'Accuracy: ${beacon.accuracy}m\nRSSI: ${beacon.rssi}',
//                                            style: TextStyle(fontSize: 13.0)),
//                                        flex: 2,
//                                        fit: FlexFit.tight)
//                                  ],
//                                ),
                              );
                            })).toList(),
                      );
                    // snapshot.data を使ったWidgetを返す
                    } else {
                    // 何かWidgetを返す
                    }
                    return Container();
                  })
            ])));
  }
}