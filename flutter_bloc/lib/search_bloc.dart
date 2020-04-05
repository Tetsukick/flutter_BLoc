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

class SearchResult {
  final int total_count;
  final List<dynamic> items;

  SearchResult(this.total_count, this.items);

  SearchResult.fromJson(Map<String, dynamic> json)
      : total_count = json['total_count'],
        items = json['items'];

  Map<String, dynamic> toJson() =>
      {
        'total_count': total_count,
        'items': items,
      };

}

class SearchResultItem {
  final String full_name;
  final int stargazers_count;
  final String html_url;

  SearchResultItem(this.full_name, this.stargazers_count, this.html_url);

  SearchResultItem.fromJson(Map<String, dynamic> json)
      : full_name = json['full_name'],
        stargazers_count = json['stargazers_count'],
        html_url = json['html_url'];

  Map<String, dynamic> toJson() =>
      {
        'full_name': full_name,
        'stargazers_count': stargazers_count,
        'html_url': html_url,
      };
}