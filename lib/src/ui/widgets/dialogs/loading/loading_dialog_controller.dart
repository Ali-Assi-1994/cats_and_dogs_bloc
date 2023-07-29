import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingDialogController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingDialogController({
    required this.close,
    required this.update,
  });
}
