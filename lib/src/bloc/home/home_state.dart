import 'package:flutter/foundation.dart' show immutable;

@immutable
class HomeState {
  final int selectedTab;

  const HomeState({
    required this.selectedTab,
  });

  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is HomeState) {
      return selectedTab == otherClass.selectedTab;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => selectedTab.hashCode;
}
