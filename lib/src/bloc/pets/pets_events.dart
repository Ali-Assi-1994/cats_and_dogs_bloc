import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class PetsEvents {
  const PetsEvents();
}

@immutable
class LoadPetsListEvent implements PetsEvents {
  const LoadPetsListEvent();
}
