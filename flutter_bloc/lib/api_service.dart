import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2')
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient client]) =>
      _$ApiService(client);

  @Get(path: "/items")
  Future<Response> fetchApi({
    @Query('query') String query = 'Flutter',
    @Query('page') int page = 1,
    @Query('sort') String sort = 'created',
    @Query('per_page') int perPage = 10,
  });
}