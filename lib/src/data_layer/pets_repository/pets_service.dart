import 'package:dogs_and_cats/src/data_layer/Dio/api.dart';

class PetsService {
  final String baseUrl;
  final String apiKey;

  PetsService({
    required this.baseUrl,
    required this.apiKey,
  });

  late ApiClient petApiClient = ApiClient(
    baseUrl: baseUrl,
    apiKey: apiKey,
  );

  Future<ApiResult> loadListOfPets({
    int? limit = 10,
    int? page = 0,
  }) async {
    return petApiClient.get(
      url: '$baseUrl/v1/images/search',
      queryParameters: {
        'limit': limit,
        'page': page,
      },
    );
  }
}
