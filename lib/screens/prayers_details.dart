import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPrayersTime extends StatelessWidget {
  final List prayerstime;
  final String mosque;
  final String docId;


  const DetailPrayersTime({super.key, required this.prayerstime, required this.mosque, required this.docId});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Prayer Times of $mosque"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffC5DFF1), Colors.white],  // You can customize the colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),),


      body: ListView.builder(
          shrinkWrap: true,
          itemCount: prayerstime.length,
          itemBuilder: (context, index) {
            dynamic prayertime = prayerstime[index];
            // Check if it's Friday (Friday corresponds to weekday 5)
            bool isFriday = DateTime.now().weekday == DateTime.friday;
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
              child:  Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Prayer Name"),

                              Text(
                                index == 2
                                    ? (isFriday
                                    ? (prayertime['prayerNameEnglish'].toString().split(','))[0]
                                    : (prayertime['prayerNameEnglish'].toString().split(','))[1])
                                    : prayertime['prayerNameEnglish'].toString(),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Prayer Time"),

                              Text(   DateFormat('hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch(prayertime["prayerTime"].seconds * 1000),
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Jammah Time"),

                              Text(   DateFormat('hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch(prayertime["jammahTime"].seconds * 1000),
                              ),),                            ],
                          ),
                          Column(
                            children: [
                              Text("Prayer End Time"),

                              Text(   DateFormat('hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch(prayertime["prayerendTime"].seconds * 1000),
                              ),),                            ],
                          ),
                          GestureDetector(
                              onTap: (){
                                // Show the dialog for editing prayer times
                                showEditDialog(context, prayertime,index);

                              },
                              child: Icon(Icons.edit)),
                      
                        ],
                      
                      
                      
                      ),
                    )),

            );
          }),
    );
  }
}
// Function to show the edit dialog
void showEditDialog(BuildContext context, dynamic prayertime,int index) {
  TextEditingController prayerTimeController =
  TextEditingController(text: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(prayertime["prayerTime"].seconds * 1000)));
  TextEditingController jammahTimeController =
  TextEditingController(text: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(prayertime["jammahTime"].seconds * 1000)));
  TextEditingController prayerEndTimeController =
  TextEditingController(text: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(prayertime["prayerendTime"].seconds * 1000)));

  Get.defaultDialog(
    title: "Edit Prayer Time",
    content: Column(
      children: [
        TextField(
          controller: prayerTimeController,
          decoration: InputDecoration(labelText: "Prayer Time"),
        ),
        TextField(
          controller: jammahTimeController,
          decoration: InputDecoration(labelText: "Jammah Time"),
        ),
        TextField(
          controller: prayerEndTimeController,
          decoration: InputDecoration(labelText: "Prayer End Time"),
        ),
      ],
    ),
    textConfirm: "Save",
    confirmTextColor: Colors.white,
    onConfirm: () async {


      Get.back(); // Close the dialog
    },
  );
}

