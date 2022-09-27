import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/features/controller/user_controller.dart';
import 'package:provider_demo/features/model/user_model.dart';
import 'package:provider_demo/features/screens/home_screen.dart';
import 'package:provider_demo/features/screens/login_screen.dart';
import 'package:provider_demo/features/screens/signup_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: UserController().user,
        builder: (context, AsyncSnapshot<UserModel> snapshot){
          final UserModel? user = snapshot.data;
          print("***** user data = ${user?.email} ******");
          if(user != null){
            return LoginScreen();
          }
          return HomeScreen();
        }
    );
  }
}
