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
    return ChangeNotifierProvider(
        create: (context) => UserController(),
      child: Consumer(
          builder: (context, UserController controller, _) {
            switch (controller.status) {
              case Status.Uninitialized:
              // TODO: Handle this case.
                break;
              case Status.Authenticated:
                HomeScreen();
                break;
              case Status.Authenticating:
                LoginScreen();
                break;
              case Status.Unauthenticated:
                SignupScreen();
                break;
              case Status.Registering:
                SignupScreen();
                break;
            }
            return LoginScreen();
          }
      )
    );
  }
}
