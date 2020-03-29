import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final searchApi = SearchApi();

  final searchQueryController = BehaviorSubject<String>();
  Stream<String> get query => searchQueryController.stream;
  StreamSink<String> get changeQuery => searchQueryController.sink;

  // APIの返り値となるSearchResult型を自作したと仮定
  final searchResultController = BehaviorSubject<SearchResult>();
  Stream<SearchResult> get result => searchResultController.stream;
  StreamSink<SearchResult> get changeResult => searchResultController.sink;

  SearchBloc() {
    query.listen((v) async {
      // APIの返り値となるSearchResult型を自作したと仮定
      final SearchResult searchResult = await searchApi.search(v);
      if (searchResult.isError) {
        changeResult.addError(searchResult);
      } else {
        changeResult.add(searchResult);
      }
    });
  }

  void dispose() {
    searchResultController.close();
    searchQueryController.close();
  }
}

class SearchApi {
  Future<SearchResult> search(String v) async {
    await Future.delayed(Duration(seconds: 1));
    return SearchResult(isError: false);
  }
}

class SearchResult {
  bool isError;
  SearchResult({this.isError});
}