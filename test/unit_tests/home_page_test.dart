import 'package:bloc_test/bloc_test.dart';
import 'package:dogs_and_cats/src/bloc/home/home_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_events.dart';
import 'package:dogs_and_cats/src/bloc/home/home_state.dart';
import 'package:dogs_and_cats/src/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Testing HomeBloc',
    () {
      late HomeBloc bloc;
      setUp(() {
        bloc = HomeBloc();
      });

      test(
        'Home page initial state',
        () => expect(bloc.state, const HomeState(selectedTab: Constants.dogsTabID)),
      );

      blocTest<HomeBloc, HomeState>(
        'test select cats tab',
        build: () => bloc,
        act: (bloc) => bloc.add(const SelectedCatsTabEvent()),
        expect: () => const [
          HomeState(selectedTab: Constants.catsTabID),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'test select dogs tab',
        build: () => bloc,
        act: (bloc) => bloc.add(const SelectedDogsTabEvent()),
        expect: () => const [
          HomeState(selectedTab: Constants.dogsTabID),
        ],
      );
    },
  );
}
