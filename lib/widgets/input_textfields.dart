import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/controllers/mosque_controllers.dart';
import 'package:prayertime_dashboard/widgets/reuse_textfields.dart';

class CustomInputFields extends StatelessWidget {
  const CustomInputFields({super.key});

  @override
  Widget build(BuildContext context) {
   final MosqueController mosqueController=Get.put(MosqueController());
    return Scaffold(
      appBar: AppBar(title: Text("iPray"),centerTitle: true,backgroundColor:Colors.lightBlueAccent,),

      body: SingleChildScrollView(
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
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                mosqueController.AddMosque();
              },
              child: Text("Add Data"),
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
