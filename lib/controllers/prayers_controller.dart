import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayertime_dashboard/controllers/mosque_controllers.dart';
import 'package:prayertime_dashboard/screens/home_screen.dart';

class PrayersController extends GetxController {
  Rx<DateTime> selectedDate=DateTime.now().obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
   List<Map<String, dynamic>> prayers = [];

  TextEditingController datetextController = TextEditingController();
  TextEditingController islamicdatecontroller = TextEditingController();

  TextEditingController fajrprayerTimecontroller = TextEditingController();
  TextEditingController fajrjammahTimecontroller = TextEditingController();
  TextEditingController fajrprayerendTimecontroller = TextEditingController();

  TextEditingController sunriseprayerTimecontroller = TextEditingController();
  TextEditingController sunrisejammahTimecontroller = TextEditingController();
  TextEditingController sunriseprayerendTimecontroller =
      TextEditingController();

  TextEditingController duhrprayerTimecontroller = TextEditingController();
  TextEditingController duhrjammahTimecontroller = TextEditingController();
  TextEditingController duhrprayerendTimecontroller = TextEditingController();

  TextEditingController asrprayerTimecontroller = TextEditingController();
  TextEditingController asrjammahTimecontroller = TextEditingController();
  TextEditingController asrprayerendTimecontroller = TextEditingController();

  TextEditingController maghribprayerTimecontroller = TextEditingController();
  TextEditingController maghribjammahTimecontroller = TextEditingController();
  TextEditingController maghribprayerendTimecontroller =
      TextEditingController();

  TextEditingController ishaprayerTimecontroller = TextEditingController();
  TextEditingController ishajammahTimecontroller = TextEditingController();
  TextEditingController ishaprayerendTimecontroller = TextEditingController();
  final MosqueController mosqueController =Get.put(MosqueController());

  DateTime _parseDateTime(String dateTimeString, String format) {
    try {
      return DateFormat(format).parse(dateTimeString);
    } catch (e) {
      print('Error parsing date-time: $e');
      // Handle the error or return a default value as needed
      return DateTime.now();
    }
  }

  Future<void> addprayers(String mosqueDocId) async {
    // Convert DateTime to Timestamp

    try {

      if (datetextController.text.isNotEmpty &&
          islamicdatecontroller.text.isNotEmpty &&
          fajrprayerTimecontroller.text.isNotEmpty &&
          fajrjammahTimecontroller.text.isNotEmpty &&
          fajrprayerendTimecontroller.text.isNotEmpty &&
          sunriseprayerTimecontroller.text.isNotEmpty &&
          sunriseprayerendTimecontroller.text.isNotEmpty &&
          duhrprayerTimecontroller.text.isNotEmpty &&
          duhrjammahTimecontroller.text.isNotEmpty &&
          duhrprayerendTimecontroller.text.isNotEmpty &&
          asrprayerTimecontroller.text.isNotEmpty &&
          asrjammahTimecontroller.text.isNotEmpty &&
          asrprayerendTimecontroller.text.isNotEmpty &&
          maghribprayerTimecontroller.text.isNotEmpty &&
          maghribjammahTimecontroller.text.isNotEmpty &&
          maghribprayerendTimecontroller.text.isNotEmpty &&
          ishaprayerTimecontroller.text.isNotEmpty &&
          ishajammahTimecontroller.text.isNotEmpty &&
          ishaprayerendTimecontroller.text.isNotEmpty)
      {

        Map<String, dynamic> prayer = {
          'date': datetextController.text,
          'islamic_date': islamicdatecontroller.text,
          'prayers': [
            {
              'daytime': 'assets/icons/subah.png',
              'prayerNameEnglish': "Fajr",
              'prayerNameArabic': "الفجر",
              'prayerTime': _parseDateTime(
                  fajrprayerTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'jammahTime': _parseDateTime(
                  fajrjammahTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'prayerendTime': _parseDateTime(
                  fajrprayerendTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
            },
            {
             'daytime': 'assets/icons/sunrise.png',
              'prayerNameEnglish': "Sunrise",
              'prayerNameArabic': "الشروق",
              'prayerTime': _parseDateTime(
                  sunriseprayerTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'jammahTime': _parseDateTime(
                  sunriseprayerTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'prayerendTime': _parseDateTime(
                  sunriseprayerendTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
            },
            {
              'daytime': 'assets/icons/zuhr.png',
              'prayerNameEnglish': "Khutbah,Dhuhr",
              'prayerNameArabic': "الظهر,خطبة",
              'prayerTime': _parseDateTime(
                  duhrprayerTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'jammahTime': _parseDateTime(
                  duhrjammahTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'prayerendTime': _parseDateTime(
                  duhrprayerendTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
            },
            {
              'daytime': 'assets/icons/asr.png',
              'prayerNameEnglish': "Asr",
              'prayerNameArabic': "العصر",
              'prayerTime': _parseDateTime(
                  asrprayerTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'jammahTime': _parseDateTime(
                  asrjammahTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'prayerendTime': _parseDateTime(
                  asrprayerendTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
            },
            {
              'daytime': 'assets/icons/maghrib.png',
              'prayerNameEnglish': "Mahrib",
              'prayerNameArabic': "المغرب",
              'prayerTime': _parseDateTime(
                  maghribprayerTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'jammahTime': _parseDateTime(
                  maghribjammahTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'prayerendTime': _parseDateTime(
                  maghribprayerendTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
            },
            {
              'daytime': 'assets/icons/isha.png',
              'prayerNameEnglish': "Isha",
              'prayerNameArabic': "العشاء",
              'prayerTime': _parseDateTime(
                  ishaprayerTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'jammahTime': _parseDateTime(
                  ishajammahTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
              'prayerendTime': _parseDateTime(
                  ishaprayerendTimecontroller.text, 'dd MMMM yyyy hh:mm a'),
            },
          ],
        };
        prayers.add(prayer);

        FirebaseFirestore firestore = FirebaseFirestore.instance;
        // Instead of set, use update
        await firestore.collection('prayerTimes').doc(mosqueDocId).update({
          'prayers': FieldValue.arrayUnion([prayer]),
        });

        mosqueController.fetchMosques();
        update();
            datetextController.clear();
            islamicdatecontroller.clear();
            fajrprayerTimecontroller.clear();
            fajrjammahTimecontroller.clear();
            fajrprayerendTimecontroller.clear();
            sunriseprayerTimecontroller.clear();
            sunrisejammahTimecontroller.clear();
            sunriseprayerendTimecontroller.clear();
            duhrprayerTimecontroller.clear();
            duhrjammahTimecontroller.clear();
            duhrprayerendTimecontroller.clear();
            asrprayerTimecontroller.clear();
            asrjammahTimecontroller.clear();
            asrprayerendTimecontroller.clear();
            maghribprayerTimecontroller.clear();
            maghribjammahTimecontroller.clear();
            maghribprayerendTimecontroller.clear();
            ishaprayerTimecontroller.clear();
            ishajammahTimecontroller.clear();
            ishaprayerendTimecontroller.clear();




        Get.snackbar('Success', 'Prayers added to the mosque');
        Get.off(HomeScreen());
      } else {
        Get.snackbar("Can't Add Data", "Enter All Fields");
      }
    } catch (e) {
      print('Error updating mosque data: $e');
      Get.snackbar('Error', 'Failed to update mosque data');
    }finally{
      update();
    }
  }


  void deletePrayer( Map<String, dynamic> prayer, String id) async{
    try{
      await firestore.collection('prayerTimes').doc(id).update({
      'prayers': FieldValue.arrayRemove([prayer])});
      Get.snackbar("Success", "Data has been deleted");
      update();

    }
    catch(e){
      print(e);

  }finally{
      update();
    }

    }


  @override
  void dispose() {
    // Dispose of all your controllers here
    datetextController.dispose();
    islamicdatecontroller.dispose();

    fajrprayerTimecontroller.dispose();
    fajrjammahTimecontroller.dispose();
    fajrprayerendTimecontroller.dispose();

    sunriseprayerTimecontroller.dispose();
    sunrisejammahTimecontroller.dispose();
    sunriseprayerendTimecontroller.dispose();

    duhrprayerTimecontroller.dispose();
    duhrjammahTimecontroller.dispose();
    duhrprayerendTimecontroller.dispose();

    asrprayerTimecontroller.dispose();
    asrjammahTimecontroller.dispose();
    asrprayerendTimecontroller.dispose();

    maghribprayerTimecontroller.dispose();
    maghribjammahTimecontroller.dispose();
    maghribprayerendTimecontroller.dispose();

    ishaprayerTimecontroller.dispose();
    ishajammahTimecontroller.dispose();
    ishaprayerendTimecontroller.dispose();

    // Dispose of other resources if needed

    super.dispose();
  }


  RxList prayertime=[].obs;

}
