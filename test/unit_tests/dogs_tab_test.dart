import 'package:bloc_test/bloc_test.dart';
import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
import 'package:dogs_and_cats/src/bloc/pets/models/pet_model.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_events.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_state.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dogs_mocked_data.dart';
import 'mocked_repositories.dart';

void main() {
  group(
    'Testing DogsBloc',
    () {
      late DogsBloc bloc;
      setUp(() {
        bloc = DogsBloc(petsRepository: MockDogsRepo());
      });

      test(
        'Dogs tab initial state',
        () => expect(bloc.state, const PetsState.empty()),
      );

      blocTest<DogsBloc, PetsState>(
        'first time fetch dogs data',
        build: () => bloc,
        act: (bloc) => bloc.add(const LoadPetsListEvent()),
        expect: () => [
          const PetsState(isLoading: true, error: null, data: null),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 10),
          ),
        ],
      );

      blocTest<DogsBloc, PetsState>(
        'load more dogs data',
        build: () => bloc,
        act: (bloc) {
          bloc.add(const LoadPetsListEvent());
          bloc.add(const LoadPetsListEvent());
          bloc.add(const LoadPetsListEvent());
          bloc.add(const LoadPetsListEvent());
          bloc.add(const LoadPetsListEvent());
        },
        expect: () => [
          const PetsState(isLoading: true, error: null, data: null),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 10),
          ),

          /// second patch
          PetsState(
            isLoading: true,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 10),
          ),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 20),
          ),

          /// third patch
          PetsState(
            isLoading: true,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 20),
          ),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 30),
          ),

          /// forth  patch
          PetsState(
            isLoading: true,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 30),
          ),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 40),
          ),

          /// fifth empty  patch, because we have only 40 dogs
          PetsState(
            isLoading: true,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 40),
          ),
          PetsState(
            isLoading: false,
            error: rangeError,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 40),
          ),
        ],
      );
    },
  );
}
