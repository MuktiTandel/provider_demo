import 'package:flutter/material.dart';

class Utils{

  void CustomSnackBar(String content, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content))
    );
  }
}