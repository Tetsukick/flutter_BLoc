import 'package:chopper/chopper.dart';

class ChopperClientCreator {
  static final String baseUrl = "https://qiita.com/api";

  static ChopperClient create() {
    return ChopperClient(
      baseUrl: ChopperClientCreator.baseUrl,
      converter: JsonConverter(),
    );
  }
}