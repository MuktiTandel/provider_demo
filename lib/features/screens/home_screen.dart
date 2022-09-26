import 'package:flutter/material.dart';
import 'package:provider_demo/core/elements/customColor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.buttoncolor,
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.logout_rounded)
          )
        ],
      ),
      body: const Padding(
          padding: EdgeInsets.all(20),
        child: Center(
          child: Text('WelCome',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: CustomColor.buttoncolor
          ),),
        ),
      ),
    );
  }
}
