import 'package:dogs_and_cats/src/bloc/pets/models/pet_model.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_events.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_state.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetsBloc extends Bloc<PetsEvents, PetsState> {
  PetsRepository petsRepository;
  late int page = 0;
  late int limit = 10;

  PetsBloc({required this.petsRepository}) : super(const PetsState.empty()) {
    on<LoadPetsListEvent>(
      (event, emit) async {

        /// start loading
        emit(
          PetsState(
            isLoading: true,
            data: state.data,
            error: null,
          ),
        );

        /// call api
        try {
          List<Pet>? result = await petsRepository.loadListOfPets(limit: limit, page: page);
          var dataList = state.data;
          if (dataList != null) {
            dataList.addAll(result!);
          } else {
            dataList = result;
          }
          page++;
          emit(
            PetsState(
              isLoading: false,
              error: null,
              data: dataList,
            ),
          );
        } catch (e) {
          emit(
            PetsState(
              isLoading: false,
              error: e,
              data: state.data,
            ),
          );
        }
      },
    );
  }
}
