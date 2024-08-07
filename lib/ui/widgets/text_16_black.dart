import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Text16Black extends StatelessWidget {
  String text;

  Text16Black({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
