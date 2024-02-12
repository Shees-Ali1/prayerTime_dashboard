import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prayertime_dashboard/auth/splash.dart';
import 'package:prayertime_dashboard/screens/home_screen.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.enablePersistence(PersistenceSettings(synchronizeTabs: true));
  FirebaseFirestore.instance.settings=Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,persistenceEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_,child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
           home: SplashScreen(),
        );
      }
    );
  }
}
