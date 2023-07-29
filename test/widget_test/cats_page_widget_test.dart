import 'dart:io';

import 'package:dogs_and_cats/generated/l10n.dart';
import 'package:dogs_and_cats/src/bloc/cats/cats_bloc.dart';
import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_bloc.dart';
import 'package:dogs_and_cats/src/ui/home_page.dart';
import 'package:dogs_and_cats/src/ui/pets_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../unit_tests/mocked_repositories.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  Future<void> prepareHomePage(WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<MockDogsRepo>(create: (context) => MockDogsRepo()),
          RepositoryProvider<MockCatsRepo>(create: (context) => MockCatsRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(),
            ),
            BlocProvider<DogsBloc>(
              create: (context) => DogsBloc(petsRepository: context.read<MockDogsRepo>()),
            ),
            BlocProvider<CatsBloc>(
              create: (context) => CatsBloc(petsRepository: context.read<MockCatsRepo>()),
            ),
          ],
          child: MaterialApp(
            home: const PetsListPage<CatsBloc>(),
            routes: {
              'home': (context) => const HomePage(),
            },
            localizationsDelegates: const [S.delegate],
            supportedLocales: S.delegate.supportedLocales,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'Test cats page widgets, with load more on scrolling down',
    (WidgetTester tester) async {
      await prepareHomePage(tester);
      await tester.pumpAndSettle();

      /// test scroll down
      await tester.scrollUntilVisible(
        find.text('Siamese'),
        100,
        scrollable: find.byType(Scrollable),
      );
    },
  );
}
