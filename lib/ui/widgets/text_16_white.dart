import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Text16White extends StatelessWidget {
  String text;

  Text16White({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
