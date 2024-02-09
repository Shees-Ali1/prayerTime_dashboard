import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/widgets/reuse_textfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MosqueInfo extends StatefulWidget {
  final dynamic mosque;


  const MosqueInfo({
    Key? key,
    required this.mosque,

  }) : super(key: key);

  @override
  _MosqueInfoState createState() => _MosqueInfoState();
}

class _MosqueInfoState extends State<MosqueInfo> {
  late TextEditingController mosqueController;
  late TextEditingController locationController;
  late TextEditingController addressController;
  late TextEditingController phoneNumberController;

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    mosqueController = TextEditingController(text: widget.mosque['mosque']);
    locationController = TextEditingController(text: widget.mosque['location']);
    addressController = TextEditingController(text: widget.mosque['address']);
    phoneNumberController = TextEditingController(text: widget.mosque['phoneNumber']);

    // Add listeners to controllers
    mosqueController.addListener(handleTextChange);
    locationController.addListener(handleTextChange);
    addressController.addListener(handleTextChange);
    phoneNumberController.addListener(handleTextChange);
  }

  void handleTextChange() {
    // Check if any text field has changed
    if (mosqueController.text !=  widget.mosque['mosque'] ||
        locationController.text != widget.mosque['location'] ||
        addressController.text != widget.mosque['address'] ||
        phoneNumberController.text != widget.mosque['phoneNumber']) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: 10.h,),
              SizedBox(
                height: 250.h,
                width: Get.width,
                child:Image.network( widget.mosque['image'], fit: BoxFit.contain,),
              ),
              ReuseTextFields(
                prefixicon: Icons.mosque,
                controller: mosqueController,
                text: 'Mosque Name',
                hintText: 'Mosque Name',
              ),
              ReuseTextFields(
                prefixicon: Icons.mosque,
                controller: locationController,
                text: 'Mosque Location',
                hintText: 'Mosque Location',
              ),
              ReuseTextFields(
                prefixicon: Icons.pin_drop,
                controller: addressController,
                text: 'Mosque Address',
                hintText: 'Mosque Address',
              ),
              ReuseTextFields(
                prefixicon: Icons.phone,
                controller: phoneNumberController,
                text: 'Phone Number',
                hintText: 'Phone Number',
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection('prayerTimes')
                        .doc( widget.mosque['docId'])
                        .set({
                      'mosque': mosqueController.text,
                      'location': locationController.text,
                      'address': addressController.text,
                      'phoneNumber': phoneNumberController.text,
                    }, SetOptions(merge: true));
                    widget.mosque['mosque']=mosqueController.text;
                    widget.mosque['location']=locationController.text;
                    widget.mosque['address']=addressController.text;
                    widget.mosque['phoneNumber']=phoneNumberController.text;
                    Get.snackbar('Success', 'Mosque Data has been updated');





                  } catch (e) {
                    print(e);
                  }
                }
                    : null,
                child: Text("Update Mosque"),
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    mosqueController.dispose();
    locationController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
