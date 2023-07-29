import 'package:dogs_and_cats/src/bloc/pets/models/pet_model.dart';
import 'package:dogs_and_cats/src/utils/extensions.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class PetsState {
  final bool isLoading;
  final List<Pet>? data;
  final Object? error;

  const PetsState({
    required this.isLoading,
    this.data,
    this.error,
  });

  const PetsState.empty()
      : isLoading = false,
        data = null,
        error = null;

  @override
  bool operator ==(covariant PetsState other) {
    bool d = isLoading == other.isLoading && error == other.error;
    if (data == null && other.data == null) {
      return d;
    } else {
      if (other.data == null) {
        return false;
      } else {
        return (data?.isEqualInOrder(other.data!) ?? false) && d;
      }
    }
  }

  @override
  int get hashCode => Object.hash(
        isLoading,
        error,
        data,
      );
}
