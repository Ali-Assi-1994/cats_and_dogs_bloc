import 'package:dogs_and_cats/src/bloc/pets/models/pet_model.dart';
import 'package:dogs_and_cats/src/data_layer/Dio/api.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_service.dart';
import 'package:dogs_and_cats/src/utils/app_secrets.dart';

class PetsRepository {
  PetsRepository();

  late String baseUrl;
  late String apiKey;
  late PetsService service = PetsService(baseUrl: baseUrl, apiKey: apiKey);

  Future<List<Pet>?> loadListOfPets({int? limit = 10, int? page = 0}) async {
    ApiResult result = await service.loadListOfPets(limit: limit, page: page);
    if (result.type == ApiResultType.success) {
      return List<Pet>.from((result.data).map((x) => Pet.fromJson(x)));
    } else {
      throw result.errorMessage;
    }
  }
}

class DogsRepo extends PetsRepository {
  DogsRepo() {
    baseUrl = 'https://api.thedogapi.com/';
    apiKey = AppSecrets.dogApiKey;
  }
}

class CatsRepo extends PetsRepository {
  CatsRepo() {
    baseUrl = 'https://api.thecatapi.com/';
    apiKey = AppSecrets.catApiKey;
  }
}
