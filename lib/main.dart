import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider_demo/features/controller/user_controller.dart';
import 'package:provider_demo/features/model/user_model.dart';
import 'package:provider_demo/features/routes/routes.dart';
import 'package:provider_demo/features/screens/home_screen.dart';
import 'package:provider_demo/features/screens/landing_screen.dart';
import 'package:provider_demo/features/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  MultiProvider(
    providers: [
      ChangeNotifierProvider<UserController>(
          create: (context) => UserController()
      ),
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: Routes.routes,
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => UserController())
            ],
          child: LandingScreen(),
        )
    );
  }
}
