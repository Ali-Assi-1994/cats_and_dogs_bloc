import 'package:dogs_and_cats/src/ui/widgets/dialogs/generic_dialog.dart';
import 'package:dogs_and_cats/src/utils/auth_errors.dart';
import 'package:flutter/material.dart' show BuildContext;

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}