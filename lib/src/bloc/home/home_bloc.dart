import 'package:dogs_and_cats/src/bloc/home/home_events.dart';
import 'package:dogs_and_cats/src/bloc/home/home_state.dart';
import 'package:dogs_and_cats/src/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc() : super(const HomeState(selectedTab: Constants.dogsTabID)) {
    on<SelectedDogsTabEvent>(
      (event, emit) async {
        emit(const HomeState(selectedTab: Constants.dogsTabID));
      },
    );

    on<SelectedCatsTabEvent>(
      (event, emit) async {
        emit(const HomeState(selectedTab: Constants.catsTabID));
      },
    );
  }
}
