import 'package:flutter/material.dart';

class EmailTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const EmailTextFieldWidget({
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: textEditingController,
        decoration: const InputDecoration(
          label: Text(
            'Email',
            style: TextStyle(color: Colors.black,fontSize: 14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: Colors.black38,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        keyboardAppearance: Brightness.dark,
      ),
    );
  }
}

class PasswordTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const PasswordTextFieldWidget({
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: textEditingController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        keyboardAppearance: Brightness.dark,
        obscuringCharacter: '*',
        decoration: const InputDecoration(
          label: Text(
            'Password',
            style: TextStyle(color: Colors.black,fontSize: 14),
          ),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.black38)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}

