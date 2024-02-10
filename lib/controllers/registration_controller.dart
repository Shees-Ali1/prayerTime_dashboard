import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/auth/register_screen.dart';
import 'package:prayertime_dashboard/screens/home_screen.dart';

class RegisterController extends GetxController{

   final FirebaseAuth auth=FirebaseAuth.instance;

   Future<void> register(TextEditingController email,TextEditingController password) async {
     try {
       await auth.createUserWithEmailAndPassword(
           email: email.text, password: password.text);
       Get.snackbar('Success', "Registration Successful");
       if (auth.currentUser != null) {
         Get.off(HomeScreen());
       }
       else {
         Get.off(RegisterScreen());
       }
     } catch (e) {
       Get.snackbar('Error', "Can't Register, Try Again");
     }
   }

  Future<void> signin(TextEditingController email,TextEditingController password)async{
    try{
      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Get.off(HomeScreen());
      Get.snackbar('Successfully Login', 'Welcome Back');
    }catch(e){
      print(e);
    }
  }



}