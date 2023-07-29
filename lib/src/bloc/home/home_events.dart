import 'package:flutter/foundation.dart' show immutable;

enum HomePageTab { dogsTab, catsTab }

@immutable
abstract class HomeEvents {
  const HomeEvents();
}

@immutable
class SelectedDogsTabEvent implements HomeEvents {
  const SelectedDogsTabEvent();
}

@immutable
class SelectedCatsTabEvent implements HomeEvents {
  const SelectedCatsTabEvent();
}
