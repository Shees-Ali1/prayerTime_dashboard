import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayertime_dashboard/controllers/mosque_controllers.dart';
import 'package:prayertime_dashboard/widgets/prayers_fileds.dart';
import 'package:prayertime_dashboard/widgets/reuse_textfields.dart';

import '../controllers/prayers_controller.dart';

class AddPrayersScreen extends StatefulWidget {
  final String docId;
  final String mosqueName;
  const AddPrayersScreen(
      {super.key, required this.docId, required this.mosqueName});

  @override
  State<AddPrayersScreen> createState() => _AddPrayersScreenState();
}

class _AddPrayersScreenState extends State<AddPrayersScreen> {
  final PrayersController prayersController = Get.put(PrayersController());

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != prayersController.datetextController.text) {
      prayersController.datetextController.value =
          TextEditingValue(text: DateFormat("MMMM d, y").format(picked));

      selectedDateTime = picked;
    }
  }

  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(
      BuildContext context, TextEditingController controller) async {
    // Use the current selectedDateTime as the initial date and time

    DateTime? pickedDateTime = selectedDateTime;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (pickedTime != null) {
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
          DateFormat('MMM dd, yyyy HH:mm').format(selectedDateTime.toLocal());
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Prayers in ${widget.mosqueName}"),
        centerTitle: true,
        flexibleSpace: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffC5DFF1),
                Colors.white
              ], // You can customize the colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffC5DFF1),
              Colors.white
            ], // You can customize the colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReuseTextFields(
                  text: 'Enter Date',
                  hintText: "February 1, 2024",
                  prefixicon: Icons.mosque,
                  controller: prayersController.datetextController,
                  onTap: () {
                    _selectDate(context);
                  },
                  onChanged: (value) {
                    print("hola");
                    prayersController.islamicdatecontroller.clear();
                    prayersController.fajrprayerTimecontroller.clear();
                    prayersController.fajrjammahTimecontroller.clear();
                    prayersController.fajrprayerendTimecontroller.clear();
                    prayersController.sunriseprayerTimecontroller.clear();
                    prayersController.sunrisejammahTimecontroller.clear();
                    prayersController.sunriseprayerendTimecontroller.clear();
                    prayersController.duhrprayerTimecontroller.clear();
                    prayersController.duhrjammahTimecontroller.clear();
                    prayersController.duhrprayerendTimecontroller.clear();
                    prayersController.asrprayerTimecontroller.clear();
                    prayersController.asrjammahTimecontroller.clear();
                    prayersController.asrprayerendTimecontroller.clear();
                    prayersController.maghribprayerTimecontroller.clear();
                    prayersController.maghribjammahTimecontroller.clear();
                    prayersController.maghribprayerendTimecontroller.clear();
                    prayersController.ishaprayerTimecontroller.clear();
                    prayersController.ishajammahTimecontroller.clear();
                    prayersController.ishaprayerendTimecontroller.clear();
                  }),
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
                            controller:
                                prayersController.fajrprayerTimecontroller,
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
                            controller:
                                prayersController.fajrjammahTimecontroller,
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
                            controller:
                                prayersController.fajrprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .fajrprayerendTimecontroller);
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
                            controller:
                                prayersController.sunriseprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .sunriseprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "06:51",
                            prefixicon: Icons.date_range_outlined,
                            controller:
                                prayersController.sunriseprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .sunriseprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "12:44",
                            prefixicon: Icons.date_range_rounded,
                            controller: prayersController
                                .sunriseprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .sunriseprayerendTimecontroller);
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
                            controller:
                                prayersController.duhrprayerTimecontroller,
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
                            controller:
                                prayersController.duhrjammahTimecontroller,
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
                            controller:
                                prayersController.duhrprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .duhrprayerendTimecontroller);
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
                            controller:
                                prayersController.asrprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.asrprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "16:01",
                            prefixicon: Icons.date_range_outlined,
                            controller:
                                prayersController.asrjammahTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.asrjammahTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "18:10",
                            prefixicon: Icons.date_range_rounded,
                            controller:
                                prayersController.asrprayerendTimecontroller,
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
                            controller:
                                prayersController.maghribprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .maghribprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "18:30",
                            prefixicon: Icons.date_range_outlined,
                            controller:
                                prayersController.maghribjammahTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .maghribjammahTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "20:30",
                            prefixicon: Icons.date_range_rounded,
                            controller: prayersController
                                .maghribprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .maghribprayerendTimecontroller);
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
                            controller:
                                prayersController.ishaprayerTimecontroller,
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
                            controller:
                                prayersController.ishajammahTimecontroller,
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
                            controller:
                                prayersController.ishaprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .ishaprayerendTimecontroller);
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(100.w, 50.h),
                    backgroundColor: Colors.black54),
                onPressed: () {
                  prayersController.addprayers(
                    widget.docId,
                  );
                },
                child: Text(
                  "Add Data",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
