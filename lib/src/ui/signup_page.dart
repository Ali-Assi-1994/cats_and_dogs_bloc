import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_events.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_state.dart';
import 'package:dogs_and_cats/src/ui/widgets/buttons_widgets.dart';
import 'package:dogs_and_cats/src/ui/widgets/dialogs/auth_error_dialog.dart';
import 'package:dogs_and_cats/src/ui/widgets/dialogs/loading/loading_dialog.dart';
import 'package:dogs_and_cats/src/ui/widgets/text_fields_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignupPage extends HookWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (_, AuthState state) {
        if (state.isLoading) {
          LoadingDialog.instance().show(
            context: context,
            text: 'Loading...',
          );
        } else {
          LoadingDialog.instance().hide();
        }
        final authError = state.authError;
        if (authError != null) {
          showAuthError(
            authError: authError,
            context: context,
          );
        }
        if (state is LoggedInState) {
          Navigator.of(context).pushReplacementNamed('home');
        }
      },
      builder: (newContext, AuthState state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: const Text("Signup"),
          ),
          body: InkWell(
            onTap: () => FocusScope.of(newContext).unfocus(),
            child: Column(
              children: [
                const SizedBox(height: 50),
                EmailTextFieldWidget(textEditingController: emailTextController),
                const SizedBox(height: 50),
                PasswordTextFieldWidget(textEditingController: passwordTextController),
                const SizedBox(height: 80),
                CustomAppButton(
                  child: const Text(
                    'Signup',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    newContext.read<AuthBloc>().add(
                          RegisterEvent(
                            email: emailTextController.text,
                            password: passwordTextController.text,
                          ),
                        );
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed('login'),
                  child: const Text("Already have an account? login here!"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
