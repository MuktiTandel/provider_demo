import 'package:flutter/cupertino.dart';
import 'package:provider_demo/features/screens/home_screen.dart';
import 'package:provider_demo/features/screens/login_screen.dart';
import 'package:provider_demo/features/screens/signup_screen.dart';

class Routes{

  Routes._();

  static const String login = '/login';
  static const String registration = '/registration';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    registration: (BuildContext context) => SignupScreen(),
    home: (BuildContext context) => HomeScreen()
  };
}