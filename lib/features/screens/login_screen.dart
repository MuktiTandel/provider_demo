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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
                   String pattern =
                       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                       r"{0,253}[a-zA-Z0-9])?)*$";
                   RegExp regex = RegExp(pattern);
                   if (val == null || val.isEmpty || !regex.hasMatch(val))
                     return 'Enter a valid email address';
                   else
                     return null;
                 },
              ),
              const SizedBox(height: 20,),
              Consumer<UserController>(
                builder: (BuildContext context, value, Widget? child) {
                  return CustomTextformfield(
                    controller: passwordController,
                    prefixicon: Icons.lock,
                    prefixiconColor: Colors.black,
                    isObscure: value.IsSecure,
                    hinttext: 'Enter Password',
                    validator: (val){
                      RegExp regex =
                      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                      if (val.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (!regex.hasMatch(val)) {
                          return 'Enter valid password';
                        } else {
                          return null;
                        }
                      }
                    },
                    suffixWidget: GestureDetector(
                        onTap: (){
                          value.checkPassword(false);
                        },
                        child: const Icon(Icons.remove_red_eye_rounded, color: Colors.black,)
                    ),
                  );
                },
              ),
              const SizedBox(height: 30,),
              CustomButton(
                ontap: () async{
                  if(formKey.currentState!.validate()){
                    FocusScope.of(context).unfocus();

                    bool status = await  UserController().loginWithEmailPassword(
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
      ),
    );
  }
}
