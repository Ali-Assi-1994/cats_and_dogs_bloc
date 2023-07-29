import 'dart:io';
import 'package:dogs_and_cats/generated/l10n.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:dogs_and_cats/src/bloc/cats/cats_bloc.dart';
import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_bloc.dart';
import 'package:dogs_and_cats/src/ui/home_page.dart';
import 'package:dogs_and_cats/src/ui/login_page.dart';
import 'package:dogs_and_cats/src/ui/signup_page.dart';
import 'package:dogs_and_cats/src/ui/widgets/buttons_widgets.dart';
import 'package:dogs_and_cats/src/ui/widgets/text_fields_widgets.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../unit_tests/mocked_repositories.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  String testEmail = 'test@course.bloc';
  final user = MockUser();

  Future<void> prepareLoginScreen(WidgetTester tester) async {
    final authLogin = MockFirebaseAuth(
      mockUser: user,
      signedIn: false,
    );

    await tester.pumpWidget(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MockDogsRepo>(create: (context) => MockDogsRepo()),
        RepositoryProvider<MockCatsRepo>(create: (context) => MockCatsRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authLogin),
          ),
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
          home: const LoginPage(),
          routes: {
            'login': (context) => const LoginPage(),
            'signup': (context) => const SignupPage(),
            'home': (context) => const HomePage(),
          },
          localizationsDelegates: const [S.delegate],
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('Test login page widgets', (WidgetTester tester) async {
    await prepareLoginScreen(tester);
    var emailTextFormField = find.byType(EmailTextFieldWidget);
    await tester.enterText(emailTextFormField, testEmail);
    await tester.pumpAndSettle();

    var passwordTextFormField = find.byType(PasswordTextFieldWidget);
    await tester.enterText(passwordTextFormField, "-");
    await tester.pumpAndSettle();

    expect(emailTextFormField, findsOneWidget);
    expect(passwordTextFormField, findsOneWidget);

    var loginButton = find.widgetWithText(CustomAppButton, 'Login');
    expect(loginButton, findsOneWidget);

    expect(find.text(S.current.cats), findsNothing);
    expect(find.text(S.current.dogs), findsNothing);

    await tester.tap(loginButton);

    await tester.pumpAndSettle();
    expect(find.text(S.current.cats), findsOneWidget);
    expect(find.text(S.current.dogs), findsOneWidget);
    expect(loginButton, findsNothing);
  });
}
