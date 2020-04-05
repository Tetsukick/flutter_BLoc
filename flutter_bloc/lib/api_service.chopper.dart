// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiService;

  @override
  Future<Response<dynamic>> fetchApi(
      {String query = 'Flutter',
      int page = 1,
      String sort = 'created',
      int perPage = 10}) {
    final $url = '/v2/items';
    final $params = <String, dynamic>{
      'query': query,
      'page': page,
      'sort': sort,
      'per_page': perPage
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
