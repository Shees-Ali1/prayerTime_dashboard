import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/auth/register_screen.dart';
import 'package:prayertime_dashboard/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToScreen();
  }

  Future<void> navigateToScreen() async {

    await Future.delayed(const Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.off(HomeScreen());
    } else {
      Get.off(RegisterScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}
