import 'package:dogs_and_cats/src/bloc/pets/models/pet_model.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_repository.dart';

import 'cats_mocked_data.dart';
import 'dogs_mocked_data.dart';

class MockCatsRepo extends PetsRepository {
  MockCatsRepo() {
    baseUrl = 'catsMockedUrl';
    apiKey = '';
  }

  @override
  Future<List<Pet>?> loadListOfPets({int? limit = 10, int? page = 0}) async {
    late List<Pet> cats;
    try {
      cats = catsMockedJsonList
          .map(
            (i) => Pet.fromJson(i),
          )
          .toList()
          .sublist(page! * limit!, page * limit + limit);
    } catch (e) {
      throw (rangeError);
    }
    return cats;
  }
}

class MockDogsRepo extends PetsRepository {
  MockDogsRepo() {
    baseUrl = 'dogsMockedUrl';
    apiKey = '';
  }

  @override
  Future<List<Pet>?> loadListOfPets({int? limit = 10, int? page = 0}) async {
    late List<Pet> dogs;
    try {
      dogs = dogsMockedJsonList
          .map(
            (i) => Pet.fromJson(i),
          )
          .toList()
          .sublist(page! * limit!, page * limit + limit);
    } catch (e) {
      throw (rangeError);
    }
    return dogs;
  }
}

RangeError rangeError = RangeError.range(50, 40, 50, 'end', 'Invalid Value');
