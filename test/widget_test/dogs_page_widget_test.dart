import 'dart:io';

import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
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
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<MockDogsRepo>(create: (context) => MockDogsRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<DogsBloc>(
              create: (context) => DogsBloc(petsRepository: context.read<MockDogsRepo>()),
            ),
          ],
          child: const MaterialApp(
            home: PetsListPage<DogsBloc>(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'Test dogs page widgets, with load more on scrolling down',
    (WidgetTester tester) async {
      await prepareHomePage(tester);

      /// test scroll down
      await tester.scrollUntilVisible(
        find.text('American Bulldog'),
        100,
        scrollable: find.byType(Scrollable),
      );
      await tester.scrollUntilVisible(
        find.text('Bull Terrier'),
        100,
        scrollable: find.byType(Scrollable),
      );
      await tester.scrollUntilVisible(
        find.text('Saint Bernard'),
        100,
        scrollable: find.byType(Scrollable),
      );
      await tester.scrollUntilVisible(
        find.text('Saluki'),
        100,
        scrollable: find.byType(Scrollable),
      );
    },
  );
}
