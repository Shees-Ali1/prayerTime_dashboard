import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/controllers/mosque_controllers.dart';
import 'package:prayertime_dashboard/widgets/prayers.dart';
import 'package:prayertime_dashboard/widgets/reuse_textfields.dart';

class CustomInputFields extends StatefulWidget {
  const CustomInputFields({super.key});

  @override
  State<CustomInputFields> createState() => _CustomInputFieldsState();
}

class _CustomInputFieldsState extends State<CustomInputFields> {
  final MosqueController mosqueController = Get.put(MosqueController());

  // Function to fetch latitude and longitude from address
  Future<void> getLatLongFromAddress(String address) async {
    if (address.isNotEmpty) {
      final apiKey = 'AIzaSyB-p7r6-G6ZT_6K1AudkhV1_TGqa7dSDKM';
      final endpoint =
          'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

      final response = await http.get(Uri.parse(endpoint));
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];

        // Update the controller values
        mosqueController.latController.text = lat.toString();
        mosqueController.lngController.text = lng.toString();
      } else {
        // Handle error, show a message, etc.
        Get.snackbar("Can't Fetch LatLng", "Enter right address");
      }
    } else {
      mosqueController.latController.text = '';
      mosqueController.lngController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Mosque"),
        centerTitle: true,
        flexibleSpace: Container(
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
                text: 'Enter Mosque Name',
                hintText: "Mosque Aqsa",
                prefixicon: Icons.mosque,
                controller: mosqueController.mosqueController,
              ),
              ReuseTextFields(
                text: 'Enter Mosque Address',
                hintText: "Bukhari centre 5-7 Wembley Hill Rd Wembley HA9 8AF",
                prefixicon: Icons.location_on,
                controller: mosqueController.addressController,
              ),
              ReuseTextFields(
                text: 'Enter Mosque Location',
                hintText: "London",
                prefixicon: Icons.location_city,
                controller: mosqueController.locationController,
                onTap: () {
                  getLatLongFromAddress(
                      mosqueController.addressController.text);
                },
              ),
              ReuseTextFields(
                text: 'Enter Mosque Image Link',
                hintText:
                    "https://t3.ftcdn.net/jpg/05/62/07/62/360_F_562076238_MrnifbcEToccZXgjcx99h48zC2AtvGGb.jpg",
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
                readonly: true,
                text: 'Enter Latitude Location',
                hintText: "50",
                prefixicon: Icons.language,
                controller: mosqueController.latController,
              ),
              ReuseTextFields(
                readonly: true,
                text: 'Enter Longitude Location',
                hintText: "71",
                prefixicon: Icons.location_on_outlined,
                controller: mosqueController.lngController,
              ),
              SizedBox(
                height: 20.h,
              ),
              prayesdata(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(100.w, 50.h),
                    backgroundColor: Colors.black54),
                onPressed: () {
                  mosqueController.AddMosque();
                },
                child: FittedBox(
                    child: Text(
                  "Add Data",
                  style: TextStyle(color: Colors.white),
                )),
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
