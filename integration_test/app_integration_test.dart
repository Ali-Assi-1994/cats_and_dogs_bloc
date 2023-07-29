import 'package:dogs_and_cats/main.dart' as app;
import 'package:dogs_and_cats/src/ui/widgets/buttons_widgets.dart';
import 'package:dogs_and_cats/src/ui/widgets/text_fields_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// flutter test integration_test/app_integration_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const Duration settleDuration = Duration(seconds: 5);

  testWidgets('Test app, user need to login case', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();
    await FirebaseAuth.instance.signOut();
    await tester.pumpAndSettle();

    var emailTextFormField = find.widgetWithText(TextField, 'Email');
    await tester.enterText(emailTextFormField, 'ali@test.com');
    await tester.pumpAndSettle();

    var passwordTextFormField = find.byType(PasswordTextFieldWidget);
    await tester.enterText(passwordTextFormField, "ali.assi");
    await tester.pumpAndSettle();

    expect(emailTextFormField, findsOneWidget);
    expect(passwordTextFormField, findsOneWidget);

    var loginButton = find.widgetWithText(CustomAppButton, 'Login');
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);

    /// home page
    await tester.pumpAndSettle(settleDuration);
    await tester.tap(find.text('Cats'));
    await tester.pumpAndSettle(settleDuration);

    await tester.tap(find.text('Dogs'));
    await tester.pumpAndSettle(settleDuration);

    await tester.tap(find.text('Cats'));
    await tester.pumpAndSettle(settleDuration);

    await FirebaseAuth.instance.signOut();
    await tester.pumpAndSettle();
  });

  testWidgets('Test app, fail to login, then login again and continue', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();
    await FirebaseAuth.instance.signOut();
    await tester.pumpAndSettle();

    var emailTextFormField = find.byType(EmailTextFieldWidget);
    await tester.enterText(emailTextFormField, 'wrong@email.com');
    await tester.pumpAndSettle();

    var passwordTextFormField = find.byType(PasswordTextFieldWidget);
    await tester.enterText(passwordTextFormField, "ali.assi");
    await tester.pumpAndSettle();

    expect(emailTextFormField, findsOneWidget);
    expect(passwordTextFormField, findsOneWidget);

    var loginButton = find.widgetWithText(CustomAppButton, 'Login');
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle(settleDuration);

    var okButton = find.widgetWithText(TextButton, 'OK');
    expect(loginButton, findsOneWidget);

    await tester.tap(okButton);
    await tester.pumpAndSettle(settleDuration);

    ///login again
    await tester.enterText(emailTextFormField, 'ali@algooru.com');
    await tester.pumpAndSettle();

    await tester.enterText(passwordTextFormField, "ali.assi");
    await tester.pumpAndSettle();

    expect(emailTextFormField, findsOneWidget);
    expect(passwordTextFormField, findsOneWidget);

    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle(settleDuration);

    /// home page
    await tester.tap(find.text('Cats'));
    await tester.pumpAndSettle(settleDuration);

    /// should not load, already loaded
    await tester.tap(find.text('Dogs'));
    await tester.pumpAndSettle(settleDuration);

    /// should not load, already loaded
    await tester.tap(find.text('Cats'));
    await tester.pumpAndSettle(settleDuration);
  });

  testWidgets('test logged-in user,dogs tap & scroll to load more', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle(settleDuration);

    final Offset point = tester.getCenter(find.byType(ListView));
    await tester.dragFrom(point, const Offset(0.0, -40000.0));

    await tester.pump();
    await tester.pumpAndSettle(settleDuration);
  });
}
