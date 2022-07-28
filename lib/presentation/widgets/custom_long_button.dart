import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomLongButton extends StatelessWidget {
  const CustomLongButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      // padding: const EdgeInsets.symmetric(horizontal: 40),
      // height: 65,
      // width: MediaQuery.of(context).size.width - 80,
      // margin: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 80,
              MediaQuery.of(context).size.height * 0.065),
          primary: kButtonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
