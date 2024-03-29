import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayertime_dashboard/controllers/prayers_controller.dart';
import 'package:prayertime_dashboard/screens/home_screen.dart';

class DetailPrayersTime extends StatefulWidget {
  final String mosque;
  final String date;
  final String docId;
  final int dateindex;

  const DetailPrayersTime({super.key,

    required this.mosque,
    required this.docId,
    required this.dateindex, required this.date});

  @override
  State<DetailPrayersTime> createState() => _DetailPrayersTimeState();
}

class _DetailPrayersTimeState extends State<DetailPrayersTime> {

  void showEditDialog(BuildContext context, dynamic prayertime, String docId,
      int index, int dateindex) {
    TextEditingController prayernameController = TextEditingController(
        text: prayertime["prayerNameEnglish"]);
    TextEditingController prayerTimeController = TextEditingController(
        text: DateFormat('dd MMMM yyyy hh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(
                prayertime["prayerTime"].seconds * 1000)));
    TextEditingController jammahTimeController = TextEditingController(
        text: DateFormat('dd MMMM yyyy hh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(
                prayertime["jammahTime"].seconds * 1000)));
    TextEditingController prayerEndTimeController = TextEditingController(
        text: DateFormat('dd MMMM yyyy hh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(
                prayertime["prayerendTime"].seconds * 1000)));

    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 4.w),
      title: "Edit Prayer Time",
      content: Column(
        children: [
          TextField(
            readOnly: true,

            controller: prayernameController,
            decoration: InputDecoration(labelText: "Prayer Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r))),

          ),
          SizedBox(height: 15.h,),

          GestureDetector(
            onTap: () {
              // Open a time picker dialog when the user taps on the time
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(
                  DateTime.fromMillisecondsSinceEpoch(
                    prayertime["prayerTime"].seconds * 1000,
                  ),
                ),
              ).then((pickedTime) {
                if (pickedTime != null) {
                  // Update the time portion in the controller
                  DateTime currentDate =
                  DateTime.fromMillisecondsSinceEpoch(
                    prayertime["prayerTime"].seconds * 1000,
                  );
                  DateTime newDateTime = DateTime(
                    currentDate.year,
                    currentDate.month,
                    currentDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  prayerTimeController.text =
                      DateFormat('dd MMMM yyyy hh:mm a').format(newDateTime);
                }
              });
            },
            child: TextField(
              controller: prayerTimeController,
              decoration: InputDecoration(labelText: "Prayer Time",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r))),
            ),
          ),
          SizedBox(height: 15.h,),

          GestureDetector(
            onTap: () {
              // Open a time picker dialog when the user taps on the time
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(
                  DateTime.fromMillisecondsSinceEpoch(
                    prayertime["jammahTime"].seconds * 1000,
                  ),
                ),
              ).then((pickedTime) {
                if (pickedTime != null) {
                  // Update the time portion in the controller
                  DateTime currentDate =
                  DateTime.fromMillisecondsSinceEpoch(
                    prayertime["jammahTime"].seconds * 1000,
                  );
                  DateTime newDateTime = DateTime(
                    currentDate.year,
                    currentDate.month,
                    currentDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  jammahTimeController.text =
                      DateFormat('dd MMMM yyyy hh:mm a').format(newDateTime);
                }
              });
            },
            child: AbsorbPointer(
              child: TextField(
                controller: jammahTimeController,
                decoration: InputDecoration(labelText: "Jammah Time",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r))),
              ),
            ),
          ),
          SizedBox(height: 15.h,),

          GestureDetector(
            onTap: () {
              // Open a time picker dialog when the user taps on the time
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(
                  DateTime.fromMillisecondsSinceEpoch(
                    prayertime["prayerendTime"].seconds * 1000,
                  ),
                ),
              ).then((pickedTime) {
                if (pickedTime != null) {
                  // Update the time portion in the controller
                  DateTime currentDate =
                  DateTime.fromMillisecondsSinceEpoch(
                    prayertime["prayerendTime"].seconds * 1000,
                  );
                  DateTime newDateTime = DateTime(
                    currentDate.year,
                    currentDate.month,
                    currentDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  prayerEndTimeController.text =
                      DateFormat('dd MMMM yyyy hh:mm a').format(newDateTime);
                }
              });
            },
            child: AbsorbPointer(
              child: TextField(
                controller: prayerEndTimeController,
                decoration: InputDecoration(labelText: "Prayer End Time",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r))),
              ),
            ),
          ),

        ],
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          updatePrayerTime(
              docId,
              dateindex,
              index,
              prayernameController,
              prayerTimeController,
              jammahTimeController,
              prayerEndTimeController);

          Get.back();
          setState(() {

          });
          // Close the dialog
        },
        child: Text("Save", style: TextStyle(color: Colors.white),),
        style: ElevatedButton.styleFrom(
            fixedSize: Size(200, 40.h),
            backgroundColor: Colors.black54

        ),

      ),


    );
  }

  void updatePrayerTime(String documentId, int dateIndex, int prayerIndex,
      TextEditingController controller,
      TextEditingController prayerTimeController,
      TextEditingController jammahTimeController,
      TextEditingController prayerEndTimeController) async {
    // Replace 'your_collection' with the actual collection name in Firestore
    CollectionReference prayersCollection =
    FirebaseFirestore.instance.collection('prayerTimes');

    // Get the document with the specified ID
    DocumentSnapshot documentSnapshot =
    await prayersCollection.doc(documentId).get();

    // Check if the document exists
    if (documentSnapshot.exists) {
      // Get the 'prayers' field from the document data
      List<dynamic> prayersList = documentSnapshot['prayers'];

      // Check if the dateIndex and prayerIndex are within bounds
      if (dateIndex >= 0 && dateIndex < prayersList.length) {
        Map<String, dynamic> dateEntry = prayersList[dateIndex];
        List<dynamic> innerPrayersList = dateEntry['prayers'];

        if (prayerIndex >= 0 && prayerIndex < innerPrayersList.length) {
          // Get the specific map in the inner 'prayers' field based on prayerIndex
          Map<String, dynamic> specificPrayerMap =
          innerPrayersList[prayerIndex];

          // Update the 'prayerNameEnglish' field in the specific map
          specificPrayerMap['prayerNameEnglish'] = controller.text;

          prayersController.prayertime[prayerIndex]["prayerNameEnglish"] =
              controller.text;
          // Update the 'prayerTime' field in the specific map
          specificPrayerMap['prayerTime'] = Timestamp.fromDate(
            DateFormat('dd MMMM yyyy hh:mm a').parse(prayerTimeController.text),
          );

          prayersController.prayertime[prayerIndex]["prayerTime"] =
              Timestamp.fromDate(
                DateFormat('dd MMMM yyyy hh:mm a').parse(
                    prayerTimeController.text),
              );

          // Update the 'jammahTime' field in the specific map
          specificPrayerMap['jammahTime'] = Timestamp.fromDate(
            DateFormat('dd MMMM yyyy hh:mm a').parse(jammahTimeController.text),
          );

          prayersController.prayertime[prayerIndex]["jammahTime"] =
              Timestamp.fromDate(
                DateFormat('dd MMMM yyyy hh:mm a').parse(
                    jammahTimeController.text),
              );

          // Update the 'prayerEndTime' field in the specific map
          specificPrayerMap['prayerendTime'] = Timestamp.fromDate(
            DateFormat('dd MMMM yyyy hh:mm a')
                .parse(prayerEndTimeController.text),
          );

          prayersController.prayertime[prayerIndex]["prayerendTime"] =
              Timestamp.fromDate(
                DateFormat('dd MMMM yyyy hh:mm a').parse(
                    prayerEndTimeController.text),
              );
        }

        await prayersCollection
            .doc(documentId)
            .update({'prayers': prayersList}).then((value) => setState(() {}));
        Get.snackbar('Success', "Prayers has been updated");
        // Get.off(HomeScreen());
      }
    }
  }

  final PrayersController prayersController = Get.put(PrayersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer Times of ${widget.mosque} at ${widget.date}"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
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
            colors: [Color(0xffC5DFF1), Colors.white],
            // You can customize the colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          return ListView.builder(
              itemCount: prayersController.prayertime.length,
              itemBuilder: (context, index) {
                dynamic prayertime = prayersController.prayertime[index];
                // String time=  jsonEncode(prayertime["prayerTime"].toDate().toString()).replaceAll(RegExp('["\']'), "");
                // print(time);
                // // Parse the date string using DateFormat
                // DateFormat dateFormat = DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z", "en_US");
                // DateTime dateTime = dateFormat.parse(time);
                DateTime prayerstime = prayertime['prayerTime'].toDate();
                var prayerTime = formatDate(prayerstime.toUtc(), [hh, ':', nn, ' ', am]);

                DateTime jammahtime = prayertime['jammahTime'].toDate();
                var jammahTime = formatDate(jammahtime.toUtc(), [hh, ':', nn, ' ', am]);

                DateTime prayersendtime = prayertime['prayerendTime'].toDate();
                var prayerendTime = formatDate(prayersendtime.toUtc(), [hh, ':', nn, ' ', am]);

                    bool isFriday = DateTime
                    .now()
                    .weekday == DateTime.friday;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.w, vertical: 10.h,),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 5.h),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        SizedBox(
                          width: 48.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Name",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                index == 2
                                    ? (isFriday
                                    ? (prayertime['prayerNameEnglish']
                                    .toString()
                                    .split(','))[0]
                                    : (prayertime['prayerNameEnglish']
                                    .toString()
                                    .split(','))[1])
                                    : prayertime['prayerNameEnglish']
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                        Column(

                          children: [
                            const Text("Prayer",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
// DateTime.now().toString(),
                              prayerTime.toString(),

                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Jammah",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(jammahTime.toString()),
                            // Text(
                            //   DateFormat('hh:mm a').format(
                            //     DateTime.fromMillisecondsSinceEpoch(
                            //         prayertime["jammahTime"].seconds * 1000),
                            //   ),
                            // ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("End Time",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(prayerendTime.toString()),
                            // Text(
                            //   DateFormat('hh:mm a').format(
                            //     DateTime.fromMillisecondsSinceEpoch(
                            //         prayertime["prayerendTime"].seconds * 1000),
                            //   ),
                            // ),
                          ],
                        ),

                        GestureDetector(
                            onTap: () {
                              // Show the dialog for editing prayer times
                              showEditDialog(context, prayertime, widget.docId,
                                  index, widget.dateindex);
                            },
                            child: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
