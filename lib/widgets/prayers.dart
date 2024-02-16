import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayertime_dashboard/controllers/mosque_controllers.dart';
import 'package:prayertime_dashboard/widgets/prayers_fileds.dart';
import 'package:prayertime_dashboard/widgets/reuse_textfields.dart';

import '../controllers/prayers_controller.dart';

class prayesdata extends StatefulWidget {
  const prayesdata({
    super.key,
  });

  @override
  State<prayesdata> createState() => _prayesdataState();
}

class _prayesdataState extends State<prayesdata> {
  final PrayersController prayersController = Get.put(PrayersController());

  DateTime selectedDateTime = DateTime.now();

  DateTime parseDateString(String dateString) {
    List<String> parts = dateString.split(' ');

    int day = int.parse(parts[0]);
    int month = parseMonth(parts[1]);
    int year = int.parse(parts[2]);
    int hour = int.parse(parts[3].split(':')[0]);
    int minute = int.parse(parts[3].split(':')[1]);
    String period = parts[4];

    // Handle leap year
    if (!DateTime.utc(year, 2, 29).isAfter(DateTime.utc(year, 2, 28))) {
      // Not a leap year, change day to 28
      day = 28;
    }

    if (period.toUpperCase() == 'PM' && hour < 12) {
      // Convert to 24-hour format if it's PM and hour is less than 12
      hour += 12;
    }

    return DateTime(year, month, day, hour, minute);
  }

  int parseMonth(String monthString) {
    switch (monthString) {
      case 'January':
        return 1;
      case 'February':
        return 2;
      case 'March':
        return 3;
      case 'April':
        return 4;
      case 'May':
        return 5;
      case 'June':
        return 6;
      case 'July':
        return 7;
      case 'August':
        return 8;
      case 'September':
        return 9;
      case 'October':
        return 10;
      case 'November':
        return 11;
      case 'December':
        return 12;
      default:
        throw ArgumentError('Invalid month string: $monthString');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != prayersController.datetextController.text) {
      prayersController.datetextController.value =
          TextEditingValue(text: DateFormat("MMMM d, y").format(picked));

      selectedDateTime = picked;

      DateTime fajrPrayerTime =
          parseAndCopyDate(prayersController.fajrprayerTimecontroller.text);
      print(fajrPrayerTime);
      DateTime fajrJammahTime =
          parseAndCopyDate(prayersController.fajrjammahTimecontroller.text);
      DateTime fajrPrayerEndTime =
          parseAndCopyDate(prayersController.fajrprayerendTimecontroller.text);

      DateTime sunrisePrayerTime =
          parseAndCopyDate(prayersController.sunriseprayerTimecontroller.text);
      DateTime sunriseJammahTime =
          parseAndCopyDate(prayersController.sunrisejammahTimecontroller.text);
      DateTime sunrisePrayerEndTime = parseAndCopyDate(
          prayersController.sunriseprayerendTimecontroller.text);

      DateTime duhrPrayerTime =
          parseAndCopyDate(prayersController.duhrprayerTimecontroller.text);
      DateTime duhrJammahTime =
          parseAndCopyDate(prayersController.duhrjammahTimecontroller.text);
      DateTime duhrPrayerEndTime =
          parseAndCopyDate(prayersController.duhrprayerendTimecontroller.text);

      DateTime asrPrayerTime =
          parseAndCopyDate(prayersController.asrprayerTimecontroller.text);
      DateTime asrJammahTime =
          parseAndCopyDate(prayersController.asrjammahTimecontroller.text);
      DateTime asrPrayerEndTime =
          parseAndCopyDate(prayersController.asrprayerendTimecontroller.text);

      DateTime maghribPrayerTime =
          parseAndCopyDate(prayersController.maghribprayerTimecontroller.text);
      DateTime maghribJammahTime =
          parseAndCopyDate(prayersController.maghribjammahTimecontroller.text);
      DateTime maghribPrayerEndTime = parseAndCopyDate(
          prayersController.maghribprayerendTimecontroller.text);

      DateTime ishaPrayerTime =
          parseAndCopyDate(prayersController.ishaprayerTimecontroller.text);
      DateTime ishaJammahTime =
          parseAndCopyDate(prayersController.ishajammahTimecontroller.text);
      DateTime ishaPrayerEndTime =
          parseAndCopyDate(prayersController.ishaprayerendTimecontroller.text);

      setState(() {
        prayersController.fajrprayerTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(fajrPrayerTime);
        print(prayersController.fajrprayerTimecontroller.text);
        prayersController.fajrjammahTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(fajrJammahTime);
        prayersController.fajrprayerendTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(fajrPrayerEndTime);

        prayersController.sunriseprayerTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(sunrisePrayerTime);
        prayersController.sunrisejammahTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(sunriseJammahTime);
        prayersController.sunriseprayerendTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(sunrisePrayerEndTime);

        prayersController.duhrprayerTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(duhrPrayerTime);
        prayersController.duhrjammahTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(duhrJammahTime);
        prayersController.duhrprayerendTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(duhrPrayerEndTime);

        prayersController.asrprayerTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(asrPrayerTime);
        prayersController.asrjammahTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(asrJammahTime);
        prayersController.asrprayerendTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(asrPrayerEndTime);

        prayersController.maghribprayerTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(maghribPrayerTime);
        prayersController.maghribjammahTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(maghribJammahTime);
        prayersController.maghribprayerendTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(maghribPrayerEndTime);

        prayersController.ishaprayerTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(ishaPrayerTime);
        prayersController.ishajammahTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(ishaJammahTime);
        prayersController.ishaprayerendTimecontroller.text =
            DateFormat('dd MMMM yyyy hh:mm a').format(ishaPrayerEndTime);
      });
    }
  }

  DateTime parseAndCopyDate(String timeText) {
    DateTime parsedTime = parseDateString(timeText);
    return parsedTime.copyWith(
      year: selectedDateTime.year,
      month: selectedDateTime.month,
      day: selectedDateTime.day,
    );
  }
  // Future<void> _selectDateTime(BuildContext context, TextEditingController controller) async {
  //   // Use the current selectedDateTime as the initial date and time
  //   TimeOfDay timeOfDay = TimeOfDay.now();
  //   try{
  //     timeOfDay = TimeOfDay.fromDateTime(parseDateString(controller.text));
  //   }catch(e){
  //     timeOfDay = TimeOfDay.now();
  //   }
  //
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: timeOfDay,
  //   );
  //   print(pickedTime);
  //   if (pickedTime != null) {
  //     // Update only the time part of the selectedDateTime
  //     selectedDateTime = DateTime(
  //       selectedDateTime.year,
  //       selectedDateTime.month,
  //       selectedDateTime.day,
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );
  //
  //
  //     // Update the text field with the formatted date and time
  //     String formattedDateTime = DateFormat('MMM dd, yyyy HH:mm').format(selectedDateTime);
  //     print(formattedDateTime);
  //     setState(() {
  //       controller.text = formattedDateTime;
  //     });
  //   }
  // }

  Future<void> _selectDateTime(
      BuildContext context, TextEditingController controller) async {
    // Use the current selectedDateTime as the initial date and time
    TimeOfDay timeOfDay = TimeOfDay.now();
    try {
      timeOfDay = TimeOfDay.fromDateTime(parseDateString(controller.text));
    } catch (e) {
      timeOfDay = TimeOfDay.now();
    }

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (pickedTime != null) {
      // Check if fajrprayerTimecontroller is being used

      if (controller == prayersController.fajrprayerTimecontroller ||
          controller == prayersController.fajrjammahTimecontroller ||
          controller == prayersController.fajrprayerendTimecontroller) {
        // Check if the selected time is in AM
        if (pickedTime.period != DayPeriod.am) {
          Get.snackbar('Error', 'Kindly select time in the AM');
          return;
        }
      }

      // Check if fajrjammahTimecontroller is being used
      if (controller == prayersController.fajrjammahTimecontroller) {
        // Check if the selected time is greater than fajrprayerTimecontroller
        TimeOfDay fajrPrayerTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.fajrprayerTimecontroller.text));

        if ((pickedTime.hour == fajrPrayerTimeOfDay.hour &&
            pickedTime.minute <= fajrPrayerTimeOfDay.minute)) {
          Get.snackbar(
              'Error', "Jammah time must be greater than Fajr prayer time");
          return;
        }
      }
      if (controller == prayersController.fajrprayerendTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.am) {
          Get.snackbar('Error', 'Kindly select time in the am');
          return;
        }

        // Check if the selected time is greater than sunriseendTimecontroller
        TimeOfDay sunriseEndTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.fajrjammahTimecontroller.text));

        if ((pickedTime.hour == sunriseEndTimeOfDay.hour &&
            pickedTime.minute <= sunriseEndTimeOfDay.minute)) {
          Get.snackbar(
              'Error', 'Fajr End Time must be greater than Fajr Jammah Time');
          return;
        }
      }
      if (controller == prayersController.sunriseprayerTimecontroller) {
        // Check if the selected time is in AM
        if (pickedTime.period != DayPeriod.am) {
          Get.snackbar('Error', 'Kindly select time in the AM');
          return;
        }

        // Check if the selected time is greater than fajrprayerendTimecontroller
        TimeOfDay fajrPrayerEndTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(
                prayersController.fajrprayerendTimecontroller.text));

        if (pickedTime.hour <= fajrPrayerEndTimeOfDay.hour ||
            (pickedTime.hour == fajrPrayerEndTimeOfDay.hour &&
                pickedTime.minute <= fajrPrayerEndTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Sunrise time must be greater than Fajr Prayer End Time');
          return;
        }
      }
      if (controller == prayersController.sunriseprayerendTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.am) {
          Get.snackbar('Error', 'Kindly select time in the am');
          return;
        }

        // Check if the selected time is greater than sunriseprayerTimecontroller
        TimeOfDay sunrisePrayerTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(
                prayersController.sunriseprayerTimecontroller.text));

        if ((pickedTime.hour == sunrisePrayerTimeOfDay.hour &&
            pickedTime.minute <= sunrisePrayerTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Sunrise End time must be greater than Sunrise Prayer Time');
          return;
        }
      }
      if (controller == prayersController.duhrprayerTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than sunriseendTimecontroller
        TimeOfDay sunriseEndTimeOfDay = TimeOfDay.fromDateTime(parseDateString(
            prayersController.sunriseprayerendTimecontroller.text));

        if (pickedTime.hour <= sunriseEndTimeOfDay.hour &&
            pickedTime.minute <= sunriseEndTimeOfDay.minute) {
          Get.snackbar('Error',
              'Duhr Prayer Time must be greater than Sunrise End Time');
          return;
        }
      }
      if (controller == prayersController.duhrjammahTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than duhrprayerTimecontroller
        TimeOfDay duhrPrayerTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.duhrprayerTimecontroller.text));

        if ((pickedTime.hour == duhrPrayerTimeOfDay.hour &&
            pickedTime.minute <= duhrPrayerTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Duhr Jammah Time must be greater than Duhr Prayer Time');
          return;
        }
      }
      if (controller == prayersController.duhrprayerendTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than duhrjammahTimecontroller
        TimeOfDay duhrJammahTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.duhrjammahTimecontroller.text));

        if ((pickedTime.hour == duhrJammahTimeOfDay.hour &&
            pickedTime.minute <= duhrJammahTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Duhr Prayer End Time must be greater than Duhr Jammah Time');
          return;
        }
      }
      if (controller == prayersController.asrprayerTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than duhrprayerendTimecontroller
        TimeOfDay duhrPrayerEndTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(
                prayersController.duhrprayerendTimecontroller.text));

        if ((pickedTime.hour == duhrPrayerEndTimeOfDay.hour &&
            pickedTime.minute <= duhrPrayerEndTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Asr Prayer Time must be greater than Duhr Prayer End Time');
          return;
        }
      }
      if (controller == prayersController.asrjammahTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than asrprayerTimecontroller
        TimeOfDay asrPrayerTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.asrprayerTimecontroller.text));

        if ((pickedTime.hour == asrPrayerTimeOfDay.hour &&
            pickedTime.minute <= asrPrayerTimeOfDay.minute)) {
          Get.snackbar(
              'Error', 'Asr Jammah Time must be greater than Asr Prayer Time');
          return;
        }
      }
      if (controller == prayersController.asrprayerendTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than asrjammahTimecontroller
        TimeOfDay asrJammahTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.asrjammahTimecontroller.text));

        if ((pickedTime.hour == asrJammahTimeOfDay.hour &&
            pickedTime.minute <= asrJammahTimeOfDay.minute)) {
          Get.snackbar(
              'Error', 'Asr Prayer Time must be greater than Asr Jammah Time');
          return;
        }
      }
      if (controller == prayersController.maghribprayerTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than asrprayerendTimecontroller
        TimeOfDay asrPrayerEndTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.asrprayerendTimecontroller.text));

        if ((pickedTime.hour == asrPrayerEndTimeOfDay.hour &&
            pickedTime.minute <= asrPrayerEndTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Maghrib Prayer Time must be greater than Asr Prayer End Time');
          return;
        }
      }
      if (controller == prayersController.maghribjammahTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than maghribprayerTimecontroller
        TimeOfDay maghribPrayerTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(
                prayersController.maghribprayerTimecontroller.text));

        if ((pickedTime.hour == maghribPrayerTimeOfDay.hour &&
            pickedTime.minute <= maghribPrayerTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Maghrib Jammah Time must be greater than Maghrib Prayer Time');
          return;
        }
      }
      if (controller == prayersController.maghribprayerendTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than maghribprayerTimecontroller
        TimeOfDay maghribPrayerTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(
                prayersController.maghribjammahTimecontroller.text));

        if ((pickedTime.hour == maghribPrayerTimeOfDay.hour &&
            pickedTime.minute <= maghribPrayerTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Maghrib Jammah Time must be greater than Maghrib Prayer Time');
          return;
        }
      }
      if (controller == prayersController.ishaprayerTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than maghribprayerendTimecontroller
        TimeOfDay maghribPrayerEndTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(
                prayersController.maghribprayerendTimecontroller.text));

        if ((pickedTime.hour == maghribPrayerEndTimeOfDay.hour &&
            pickedTime.minute <= maghribPrayerEndTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Isha Prayer Time must be greater than Maghrib Prayer End Time');
          return;
        }
      }
      if (controller == prayersController.ishajammahTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than ishaprayerTimecontroller
        TimeOfDay ishaPrayerTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.ishaprayerTimecontroller.text));

        if ((pickedTime.hour == ishaPrayerTimeOfDay.hour &&
            pickedTime.minute <= ishaPrayerTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Isha Jammah Time must be greater than Isha Prayer Time');
          return;
        }
      }
      if (controller == prayersController.ishaprayerendTimecontroller) {
        // Check if the selected time is in PM
        if (pickedTime.period != DayPeriod.pm) {
          Get.snackbar('Error', 'Kindly select time in the PM');
          return;
        }

        // Check if the selected time is greater than ishajammahTimecontroller
        TimeOfDay ishaJammahTimeOfDay = TimeOfDay.fromDateTime(
            parseDateString(prayersController.ishajammahTimecontroller.text));

        if ((pickedTime.hour == ishaJammahTimeOfDay.hour &&
            pickedTime.minute <= ishaJammahTimeOfDay.minute)) {
          Get.snackbar('Error',
              'Isha Prayer End Time must be greater than Isha Jammah Time');
          return;
        }
      }

      // Update only the time part of the selectedDateTime
      selectedDateTime = DateTime(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Update the text field with the formatted date and time
      String formattedDateTime =
          DateFormat('dd MMMM yyyy hh:mm a').format(selectedDateTime);
      print(formattedDateTime);
      setState(() {
        controller.text = formattedDateTime;
      });
    }
  }

  final TextEditingController fajrnamecontroller = TextEditingController();
  final TextEditingController sunrisenamecontroller = TextEditingController();
  final TextEditingController duhrnamecontroller = TextEditingController();
  final TextEditingController asrnamecontroller = TextEditingController();
  final TextEditingController maghribnamecontroller = TextEditingController();
  final TextEditingController ishanamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fajrnamecontroller.text = 'Fajr';
    sunrisenamecontroller.text = 'Sunrise';
    duhrnamecontroller.text = 'Duhr';
    asrnamecontroller.text = 'Asr';
    maghribnamecontroller.text = 'Maghrib';
    ishanamecontroller.text = 'Isha';

    return Column(
      children: [
        ReuseTextFields(
          text: 'Enter Date',
          hintText: "February 1, 2024",
          prefixicon: Icons.mosque,
          controller: prayersController.datetextController,
          onTap: () {
            _selectDate(context);
          },
        ),
        ReuseTextFields(
          text: 'Enter Islamic Date',
          hintText: "Rajab 20, 1445 AH",
          prefixicon: Icons.location_city,
          controller: prayersController.islamicdatecontroller,
        ),
        SizedBox(
          height: 20.h,
        ),
        Divider(
          color: Colors.teal,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrayersField(
                      text: "Prayer Name",
                      enabled: false,
                      hintText: "Fajr",
                      prefixicon: Icons.nights_stay_outlined,
                      controller: fajrnamecontroller,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      text: "Prayer Time",
                      hintText: "04:44",
                      prefixicon: Icons.web,
                      controller: prayersController.fajrprayerTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.fajrprayerTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      text: "Prayer Jammah Time",
                      hintText: "05:00",
                      prefixicon: Icons.web,
                      controller: prayersController.fajrjammahTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.fajrjammahTimecontroller);
                      },
                    ),
                    SizedBox(width: 20.w),
                    PrayersField(
                      text: "Prayer End Time",
                      hintText: "06:50",
                      prefixicon: Icons.web,
                      controller: prayersController.fajrprayerendTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.fajrprayerendTimecontroller);
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrayersField(
                      enabled: false,
                      hintText: "Sunrise",
                      prefixicon: Icons.sunny,
                      controller: sunrisenamecontroller,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "06:51",
                      prefixicon: Icons.date_range,
                      controller: prayersController.sunriseprayerTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.sunriseprayerTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "06:51",
                      prefixicon: Icons.date_range_outlined,
                      controller: prayersController.sunriseprayerTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.sunriseprayerTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "12:44",
                      prefixicon: Icons.date_range_rounded,
                      controller:
                          prayersController.sunriseprayerendTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.sunriseprayerendTimecontroller);
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrayersField(
                      enabled: false,
                      hintText: "Duhr",
                      prefixicon: Icons.wb_sunny_sharp,
                      controller: duhrnamecontroller,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "12:45",
                      prefixicon: Icons.date_range,
                      controller: prayersController.duhrprayerTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.duhrprayerTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "13:00",
                      prefixicon: Icons.date_range_outlined,
                      controller: prayersController.duhrjammahTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.duhrjammahTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "15:44",
                      prefixicon: Icons.date_range_rounded,
                      controller: prayersController.duhrprayerendTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.duhrprayerendTimecontroller);
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrayersField(
                      enabled: false,
                      hintText: "Asr",
                      prefixicon: Icons.wb_sunny_sharp,
                      controller: asrnamecontroller,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "15:45",
                      prefixicon: Icons.date_range,
                      controller: prayersController.asrprayerTimecontroller,
                      onTap: () {
                        _selectDateTime(
                            context, prayersController.asrprayerTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "16:01",
                      prefixicon: Icons.date_range_outlined,
                      controller: prayersController.asrjammahTimecontroller,
                      onTap: () {
                        _selectDateTime(
                            context, prayersController.asrjammahTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "18:10",
                      prefixicon: Icons.date_range_rounded,
                      controller: prayersController.asrprayerendTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.asrprayerendTimecontroller);
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrayersField(
                      enabled: false,
                      hintText: "Maghrib",
                      prefixicon: Icons.dark_mode_outlined,
                      controller: maghribnamecontroller,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "18:11",
                      prefixicon: Icons.date_range,
                      controller: prayersController.maghribprayerTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.maghribprayerTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "18:30",
                      prefixicon: Icons.date_range_outlined,
                      controller: prayersController.maghribjammahTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.maghribjammahTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "20:30",
                      prefixicon: Icons.date_range_rounded,
                      controller:
                          prayersController.maghribprayerendTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.maghribprayerendTimecontroller);
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrayersField(
                      enabled: false,
                      hintText: "Isha",
                      prefixicon: Icons.nights_stay,
                      controller: ishanamecontroller,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "20:31",
                      prefixicon: Icons.date_range,
                      controller: prayersController.ishaprayerTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.ishaprayerTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "20:50",
                      prefixicon: Icons.date_range_outlined,
                      controller: prayersController.ishajammahTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.ishajammahTimecontroller);
                      },
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    PrayersField(
                      hintText: "23:59",
                      prefixicon: Icons.date_range_rounded,
                      controller: prayersController.ishaprayerendTimecontroller,
                      onTap: () {
                        _selectDateTime(context,
                            prayersController.ishaprayerendTimecontroller);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
