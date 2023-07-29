import 'package:dogs_and_cats/src/utils/auth_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
abstract class AuthState {
  final bool isLoading;
  final AuthError? authError;

  const AuthState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
class LoggedInState extends AuthState {
  final User? user;

  const LoggedInState({
    required bool isLoading,
    required this.user,
  }) : super(
          isLoading: isLoading,
          authError: null,
        );

  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is LoggedInState) {
      return isLoading == otherClass.isLoading && user?.email == otherClass.user?.email && authError == otherClass.authError;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        isLoading,
        user.hashCode,
        authError,
      );
}

@immutable
class LoggedOutState extends AuthState {
  const LoggedOutState({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is LoggedOutState) {
      return isLoading == otherClass.isLoading && authError == otherClass.authError;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        isLoading,
        authError,
      );
}
