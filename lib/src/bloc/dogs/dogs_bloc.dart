import 'package:dogs_and_cats/src/bloc/pets/pets_bloc.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_repository.dart';

class DogsBloc extends PetsBloc {
  DogsBloc({
    required PetsRepository petsRepository,
  }) : super(
          petsRepository: petsRepository,
        );
}
