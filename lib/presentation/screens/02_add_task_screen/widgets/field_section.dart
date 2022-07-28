import 'package:flutter/material.dart';

class FieldSection extends StatelessWidget {
  const FieldSection({
    Key? key,
    required this.title,
    required this.child,
    this.isSmallMarginRight = false,
    this.isSmallMarginLeft = false,
  }) : super(key: key);

  final String title;
  final Widget child;
  final bool isSmallMarginRight;
  final bool isSmallMarginLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        !isSmallMarginLeft ? 40 : 10,
        30,
        !isSmallMarginRight ? 40 : 10,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade50,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
