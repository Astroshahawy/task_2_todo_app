import 'package:flutter/material.dart';

class NoTaskText extends StatelessWidget {
  final String text;
  const NoTaskText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black54,
        ),
      ),
    );
  }
}
