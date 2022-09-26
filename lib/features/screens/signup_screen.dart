import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/core/elements/customColor.dart';
import 'package:provider_demo/core/elements/custom_textformfield.dart';
import 'package:provider_demo/core/utils.dart';
import 'package:provider_demo/features/controller/user_controller.dart';
import 'package:provider_demo/features/model/user_model.dart';
import 'package:provider_demo/features/screens/login_screen.dart';

import '../../core/elements/custom_richtext.dart';
import '../../core/elements/custombutton.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conf_password_controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {

    return Provider(
      create: (context) => UserController(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              key: formKey,
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sign Up',
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
                            return 'Please Enter Email';
                          }
                        },
                      ),
                      const SizedBox(height: 20,),
                      CustomTextformfield(
                        controller: passwordController,
                        prefixicon: Icons.lock,
                        prefixiconColor: Colors.black,
                        hinttext: 'Enter Password',
                        suffixWidget: GestureDetector(
                            onTap: (){},
                            child: const Icon(Icons.remove_red_eye_rounded, color: Colors.black,)
                        ),
                        validator: (val){
                          if(val.isEmpty){
                            return 'Please Enter Password';
                          }
                        },
                      ),
                      const SizedBox(height: 20,),
                      CustomTextformfield(
                        controller: conf_password_controller,
                        prefixicon: Icons.lock,
                        prefixiconColor: Colors.black,
                        hinttext: 'Confirm Password',
                        suffixWidget: GestureDetector(
                            onTap: (){},
                            child: const Icon(Icons.remove_red_eye_rounded, color: Colors.black,)
                        ),
                        validator: (val){
                          if(val.isEmpty){
                            return 'Please Enter valid Password';
                          }
                        },
                      ),
                      const SizedBox(height: 30,),
                      CustomButton(
                        ontap: () async{
                          if(formKey.currentState!.validate()){
                            FocusScope.of(context).unfocus();

                            UserModel usermodel = await UserController().registerWithEmailPassword(
                                emailController.text, passwordController.text);

                            if(usermodel == null){
                              utils.CustomSnackBar('Somthing Went Wrong', context);
                            }else{
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        buttontext: 'Sign Up',
                      ),
                      const SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        child: const CustomRichtext(
                          title: "Already have an account? ",
                          childtext: 'Sign In',
                        ),
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
