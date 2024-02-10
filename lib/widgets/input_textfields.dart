import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/controllers/mosque_controllers.dart';
import 'package:prayertime_dashboard/widgets/reuse_textfields.dart';

class CustomInputFields extends StatelessWidget {
  const CustomInputFields({super.key});

  @override
  Widget build(BuildContext context) {
   final MosqueController mosqueController=Get.put(MosqueController());
    return Scaffold(
      appBar: AppBar(title: Text("Add Mosque"),centerTitle: true,flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffC5DFF1), Colors.white],  // You can customize the colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),),

      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffC5DFF1), Colors.white],  // You can customize the colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReuseTextFields(
                text: 'Enter Mosque Name',
                hintText: "Mosque Aqsa",
                prefixicon: Icons.mosque,
                controller: mosqueController.mosqueController,
              ),
              ReuseTextFields(
                text: 'Enter Mosque Location',
                hintText: "London",
                prefixicon: Icons.location_city,
                controller: mosqueController.locationController,
              ),
              ReuseTextFields(
                text: 'Enter Mosque Address',
                hintText: "Bukhari centre 5-7 Wembley Hill Rd Wembley HA9 8AF",
                prefixicon: Icons.location_on,
                controller: mosqueController.addressController,
              ),
              ReuseTextFields(
                text: 'Enter Mosque Image Link',
                hintText: "https://t3.ftcdn.net/jpg/05/62/07/62/360_F_562076238_MrnifbcEToccZXgjcx99h48zC2AtvGGb.jpg",
                prefixicon: Icons.image,
                controller: mosqueController.imageController,
              ),
              ReuseTextFields(
                text: 'Enter Phone Number',
                hintText: "+123456789",
                prefixicon: Icons.phone,
                controller: mosqueController.phoneController,
              ),
              ReuseTextFields(
                text: 'Enter Website',
                hintText: "wembley.com",
                prefixicon: Icons.web,
                controller: mosqueController.websiteController,
              ),
              ReuseTextFields(
                text: 'Enter Latitude Location',
                hintText: "50",
                prefixicon: Icons.language,
                controller: mosqueController.latController,
              ),
              ReuseTextFields(
                text: 'Enter Longitude Location',
                hintText: "71",
                prefixicon: Icons.location_on_outlined,
                controller: mosqueController.lngController,
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(

                style: ElevatedButton.styleFrom(
                    fixedSize: Size(100.w, 50.h),
                    backgroundColor: Colors.black54

                ),
                onPressed: () {
                  mosqueController.AddMosque();
                },
                child: FittedBox(child: Text("Add Data",style: TextStyle(color: Colors.white),)),
              ),
              SizedBox(height: 20.h,),

            ],
          ),
        ),
      ),
    );
  }
}
