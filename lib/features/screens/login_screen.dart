import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/core/elements/customColor.dart';
import 'package:provider_demo/core/elements/custom_richtext.dart';
import 'package:provider_demo/core/elements/custom_textformfield.dart';
import 'package:provider_demo/core/elements/custombutton.dart';
import 'package:provider_demo/core/utils.dart';
import 'package:provider_demo/features/controller/user_controller.dart';
import 'package:provider_demo/features/screens/home_screen.dart';
import 'package:provider_demo/features/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserController>(context);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login',
              style: TextStyle(
                  color: CustomColor.buttoncolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ),
            const SizedBox(height: 40,),
             CustomTextformfield(
              controller: emailController,
              prefixicon: Icons.email_rounded,
              prefixiconColor: Colors.black,
              hinttext: 'Enter Email',
               validator: (val){
                if(val.isEmpty){
                  return 'Please Enter Email!';
                }
               },
            ),
            const SizedBox(height: 20,),
            CustomTextformfield(
              controller: passwordController,
              prefixicon: Icons.lock,
              prefixiconColor: Colors.black,
              hinttext: 'Enter Password',
              validator: (val){
                if(val.isEmpty){
                  return 'Please Enter password';
                }
              },
              suffixWidget: GestureDetector(
                  onTap: (){},
                  child: const Icon(Icons.remove_red_eye_rounded, color: Colors.black,)
              ),
            ),
            const SizedBox(height: 30,),
            CustomButton(
              ontap: () async{
                if(formKey.currentState!.validate()){
                  FocusScope.of(context).unfocus();

                  bool status = await  authProvider.loginWithEmailPassword(
                      emailController.text, passwordController.text);

                  if(!status){
                    utils.CustomSnackBar("Something Went Wrong", context);
                  }else{
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }
                }
              },
              buttontext: 'Sign In',
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
              },
              child: const CustomRichtext(
                title: "Don't have an account? ",
                childtext: 'Sign Up',
              ),
            )
          ],
        )
            )
        ),
      ),
    );
  }
}
