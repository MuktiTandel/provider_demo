import 'package:flutter/material.dart';
import 'package:provider_demo/core/elements/customColor.dart';

class CustomRichtext extends StatelessWidget {
  const CustomRichtext({
    Key? key,
    required this.childtext,
    required this.title
  }) : super(key: key);

  final String title;
  final String childtext;

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(
      text: title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15
      ),
      children: [
        TextSpan(
          text: childtext,
          style: TextStyle(
            color: CustomColor.buttoncolor,
            fontSize: 15,
            fontWeight: FontWeight.w600
          )
        )
      ]
    ));
  }
}
