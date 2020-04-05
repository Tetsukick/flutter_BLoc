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
                      return Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, int index) {
                              var item = snapshot.data[index];
                              return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black38),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(item['full_name']),
                                    subtitle: Text('Star: ' + item['stargazers_count'].toString()),
                                    onTap: () { /* react to the tile being tapped */ },
                                  ));
                            }),
                      );
                    }
                    return Container();
                  })
            ])));
  }
}