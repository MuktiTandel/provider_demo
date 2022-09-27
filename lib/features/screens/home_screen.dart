import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/core/elements/customColor.dart';
import 'package:provider_demo/features/controller/user_controller.dart';
import 'package:provider_demo/features/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => UserController(),
      builder: (BuildContext context, Widget? child){
        return  Scaffold(
          appBar: AppBar(
            title: const Text('Home Screen'),
            automaticallyImplyLeading: false,
            backgroundColor: CustomColor.buttoncolor,
            actions: [
              IconButton(
                  onPressed: (){
                    final authservice = Provider.of<UserController>(context, listen: false);
                    authservice.signOut();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                  },
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
      },
    );
  }
}
