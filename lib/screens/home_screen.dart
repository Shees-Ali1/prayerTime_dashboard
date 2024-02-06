import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/controllers/mosque_controllers.dart';
import 'package:prayertime_dashboard/screens/prayerstime_screen.dart';
import 'package:prayertime_dashboard/widgets/input_textfields.dart';

import 'AddPrayersScreen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MosqueController mosqueController = Get.put(MosqueController());
    TextEditingController searchController = TextEditingController();

    return GetBuilder<MosqueController>(builder: (logic) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {

              Get.to(CustomInputFields());
            }, child: Icon(Icons.mosque), tooltip: "Add Mosque",),
          appBar: AppBar(title: Text("iPray"),
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
          body: Column(
            children: [
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: SizedBox(
                  width: 358.w,
                  height: 42.h,
                  child: TextField(

                    controller: searchController, // Use the search controller
                    onChanged: (value) {
                      // Update the searchQuery in the controller
                      mosqueController.updateSearchQuery(value);
                    },
                    decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          size: 16,

                        ),

                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xff06446C).withOpacity(0.3)),
                            borderRadius:
                            BorderRadius.circular(26.w)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xff06446C).withOpacity(0.3)),
                            borderRadius:
                            BorderRadius.circular(26.w))),
                  ),
                ),
              ),
              SizedBox(height: 10.h,),



              ListView.builder(
                  shrinkWrap: true,
                  itemCount: mosqueController.filteredMosques.length,
                  itemBuilder: (context, index) {
                    final mosques = mosqueController.filteredMosques[index];
                    final prayers= mosques['prayers'];
                    final docid= mosques['docId'];
                    final mosqueName= mosques['mosque'];
                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(PrayersTimeScreen(prayers: prayers, docId: docid,mosque:mosqueName));

                        },
                        child: Card(
                            child: ListTile(
                              title: Text(mosques['mosque']),
                              subtitle: Text(mosques['location']),
                              trailing: GestureDetector(
                                  onTap: (){
                                    mosqueController.deleteMosque(docid);


                                  },
                                  child: Icon(Icons.delete)),

                            )),
                      ),
                    );
                  }),
            ],
          ),


      );
    });
  }
}
