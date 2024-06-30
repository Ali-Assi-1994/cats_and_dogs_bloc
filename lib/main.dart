import 'package:dogs_and_cats/generated/l10n.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:dogs_and_cats/src/bloc/cats/cats_bloc.dart';
import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_bloc.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_repository.dart';
import 'package:dogs_and_cats/src/ui/home_page.dart';
import 'package:dogs_and_cats/src/ui/login_page.dart';
import 'package:dogs_and_cats/src/ui/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('MyApp here');
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DogsRepo>(create: (context) => DogsRepo()),
        RepositoryProvider<CatsRepo>(create: (context) => CatsRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
          BlocProvider<DogsBloc>(create: (context) => DogsBloc(petsRepository: context.read<DogsRepo>())),
          BlocProvider<CatsBloc>(create: (context) => CatsBloc(petsRepository: context.read<CatsRepo>())),
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(FirebaseAuth.instance)),
        ],
        child: MaterialApp(
          title: 'Dogs & Cats',
          theme: ThemeData(primaryColor: Colors.black),
          routes: {
            'login': (context) => const LoginPage(),
            'signup': (context) => const SignupPage(),
            'home': (context) => const HomePage(),
          },
          home: FirebaseAuth.instance.currentUser == null ? const LoginPage() : const HomePage(),
          localizationsDelegates: const [S.delegate],
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    );
  }
}