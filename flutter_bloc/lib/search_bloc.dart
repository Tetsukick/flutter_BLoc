import 'dart:async';
import 'package:flutterbloc/api_service.dart';
import 'package:rxdart/rxdart.dart';
import 'chopper_client_creater.dart';

import 'package:chopper/chopper.dart';

class SearchBloc {
  final searchApi = SearchApi();

  final searchQueryController = BehaviorSubject<String>();
  Stream<String> get query => searchQueryController.stream;
  StreamSink<String> get changeQuery => searchQueryController.sink;

  // APIの返り値となるSearchResult型を自作したと仮定
  final searchResultController = BehaviorSubject<List<SearchResult>>();
  Stream<List<SearchResult>> get result => searchResultController.stream;
  StreamSink<List<SearchResult>> get changeResult => searchResultController.sink;

  SearchBloc() {
    query.listen((v) async {
      // APIの返り値となるSearchResult型を自作したと仮定
      final List<SearchResult> searchResults = await searchApi.fetchApi();
      print("------");
      print(searchResults);
      print("------");
      if (searchResults.isEmpty) {
        changeResult.addError(searchResults);
      } else {
        changeResult.add(searchResults);
      }
    });
  }

  void dispose() {
    searchResultController.close();
    searchQueryController.close();
  }
}

class SearchApi {
  final ApiService service =
  ApiService.create(ChopperClientCreator.create());

  Future<List<SearchResult>> fetchApi() async {
    final Response response = await service.fetchApi();
    if (response.isSuccessful) {
      print(response.body);
//      final responseBodyJson = response.body as List<Map<String, dynamic>>;
      // jsonのパース
//      return response.body;
    }
  }
}

class SearchResult {
  String title;
  int likes_count;
  String created_at;
}