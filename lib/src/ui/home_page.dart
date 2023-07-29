import 'package:dogs_and_cats/generated/l10n.dart';
import 'package:dogs_and_cats/src/bloc/cats/cats_bloc.dart';
import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_events.dart';
import 'package:dogs_and_cats/src/bloc/home/home_state.dart';
import 'package:dogs_and_cats/src/ui/pets_list_page.dart';
import 'package:dogs_and_cats/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.black, toolbarHeight: 10),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (selectedTab) {
              switch (selectedTab) {
                case Constants.dogsTabID:
                  context.read<HomeBloc>().add(const SelectedDogsTabEvent());
                  break;
                case Constants.catsTabID:
                  context.read<HomeBloc>().add(const SelectedCatsTabEvent());
                  break;
              }
            },
            currentIndex: state.selectedTab,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            elevation: 0,
            showSelectedLabels: false,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                label: S.of(context).dogs,
                icon: Image.asset(state.selectedTab == Constants.dogsTabID ? 'assets/icons/dog_filled.png' : 'assets/icons/dog.png', height: 35),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                label: S.of(context).cats,
                icon: Image.asset(state.selectedTab == Constants.catsTabID ? 'assets/icons/cat_filled.png' : 'assets/icons/cat.png', height: 35),
              ),
            ],
          ),
          body: state.selectedTab == 0 ? const PetsListPage<DogsBloc>() : const PetsListPage<CatsBloc>(),
        );
      },
    );
  }
}
