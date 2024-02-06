import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/controllers/prayers_controller.dart';
import 'package:prayertime_dashboard/screens/AddPrayersScreen.dart';
import 'package:prayertime_dashboard/screens/prayers_details.dart';

class PrayersTimeScreen extends StatefulWidget {
  final List prayers;
  final String docId;
  final String mosque;

  const PrayersTimeScreen(
      {super.key, required this.prayers, required this.docId, required this.mosque});

  @override
  State<PrayersTimeScreen> createState() => _PrayersTimeScreenState();
}

class _PrayersTimeScreenState extends State<PrayersTimeScreen> {
  @override
  Widget build(BuildContext context) {
    final PrayersController prayersController = Get.put(PrayersController());
    return GetBuilder<PrayersController>(builder: (logic) {

      return Scaffold(
        appBar: AppBar(title: Text(widget.mosque),
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
        floatingActionButton: FloatingActionButton(onPressed: (){
          Get.to(AddPrayersScreen(docId: widget.docId, mosqueName:widget.mosque,));



        },tooltip:'Add Prayer Times',child: Icon(Icons.add),),
        body:
         widget.prayers.isEmpty?
         Center(
          child: Text("No Prayers Data Found"),
        ):



        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.prayers.length,
            itemBuilder: (context, index) {
              dynamic prayer = widget.prayers[index];
              final prayertime = prayer['prayers'];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(DetailPrayersTime(prayerstime: prayertime,mosque:widget.mosque,docId:widget.docId,));
                    },
                    child: Card(
                        child: ListTile(
                      title: Text(prayer['date'] ?? ""),
                      subtitle: Text(prayer['islamic_date'] ?? ''),
                      trailing: GestureDetector(
                          onTap: () {
                            prayersController.deletePrayer(prayer, widget.docId);
                            widget.prayers.removeAt(index);
                            setState(() {

                            });
                          },
                          child: Icon(Icons.delete)),
                    )),
                  ),
                );
              }
            ),
      );
    });
  }
}
