import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const CustomAppButton({Key? key, required this.child, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          fixedSize: MaterialStateProperty.all(const Size.fromHeight(60)),
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
            ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
