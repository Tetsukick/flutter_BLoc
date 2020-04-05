import 'dart:async';
import 'dart:convert';
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
  final searchResultController = BehaviorSubject<List<dynamic>>();
  Stream<List<dynamic>> get result => searchResultController.stream;
  StreamSink<List<dynamic>> get changeResult => searchResultController.sink;

  SearchBloc() {
    query.listen((v) async {
      // APIの返り値となるSearchResult型を自作したと仮定
      final List<dynamic> searchResults = await searchApi.fetchApi(query: v);
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

  Future<List<dynamic>> fetchApi({String query}) async {
    final Response response = await service.fetchApi(query: query);
    if (response.isSuccessful) {
      return response.body['items'];
    } else {
      print(response.error);
    }
  }
}