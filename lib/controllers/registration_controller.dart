import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/auth/register_screen.dart';
import 'package:prayertime_dashboard/screens/home_screen.dart';

class RegisterController extends GetxController{

   final FirebaseAuth auth=FirebaseAuth.instance;
   RxBool isLoading = false.obs;

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
      isLoading.value = true;

      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Get.off(HomeScreen());
      Get.snackbar('Successfully Login', 'Welcome Back');
    }catch(e){
      Get.snackbar('Error', "Confirm your mail and password or Try Again");
    }finally {
      // Set isLoading to false when the sign-in process is completed
      isLoading.value = false;
    }
  }



}