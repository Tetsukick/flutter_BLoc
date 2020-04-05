import 'package:chopper/chopper.dart';

class ChopperClientCreator {
  static final String baseUrl = "https://api.github.com/search";

  static ChopperClient create() {
    return ChopperClient(
      baseUrl: ChopperClientCreator.baseUrl,
      converter: JsonConverter(),
    );
  }
}