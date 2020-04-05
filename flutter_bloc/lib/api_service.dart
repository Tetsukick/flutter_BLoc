import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient client]) =>
      _$ApiService(client);

  @Get(path: "/repositories")
  Future<Response> fetchApi({
    @Query('q') String query,
    @Query('sort') String sort = 'stars'
  });
}