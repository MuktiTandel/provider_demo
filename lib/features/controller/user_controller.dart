import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider_demo/features/model/user_model.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated, Registering }

class UserController with ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;

  Status status = Status.Uninitialized;

  Status get _status => status;

  Stream<UserModel> get user => auth.authStateChanges().map(userFromFirebase);

  UserController() {
    auth.authStateChanges().listen(onAuthStateChange);
  }

  // Get User
  UserModel userFromFirebase(User? user){

    if(user == null){
      return UserModel(email: 'empty');
    }

    return UserModel(
        email: user.email!,
      userid: user.uid
    );
  }

  // detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChange(User? firebaseuser) async{

    if(firebaseuser == null){
      status = Status.Uninitialized;
    }else {
      userFromFirebase(firebaseuser);
      status = Status.Authenticated;
    }

    notifyListeners();
  }

  //registration using email and password
  Future<UserModel> registerWithEmailPassword(String email, String password) async{
    try {
      status = Status.Registering;
      notifyListeners();
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return userFromFirebase(userCredential.user);
    } catch (e) {
      print('**** Error on new registration = ${e.toString()} ****');
      status = Status.Unauthenticated;
      notifyListeners();
      return UserModel(email: 'email');
    }
  }

  //login using email and passwords
  Future<bool> loginWithEmailPassword(String email, String password) async{

    try {
      status = Status.Authenticating;
      notifyListeners();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("***** Error on the Login = ${e.toString()} *****");
      status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // User sign out
  Future signOut() async{
    auth.signOut();
    status = Status.Unauthenticated;
    notifyListeners();
  }

}