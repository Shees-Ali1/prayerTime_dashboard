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
  late TextEditingController latController;
  late TextEditingController lngController;

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    mosqueController = TextEditingController(text: widget.mosque['mosque']);
    locationController = TextEditingController(text: widget.mosque['location']);
    addressController = TextEditingController(text: widget.mosque['address']);
    phoneNumberController = TextEditingController(text: widget.mosque['phoneNumber']);
    latController = TextEditingController(text: widget.mosque['latlng'].latitude.toString());
    lngController = TextEditingController(text: widget.mosque['latlng'].longitude.toString());

    // Add listeners to controllers
    mosqueController.addListener(handleTextChange);
    locationController.addListener(handleTextChange);
    addressController.addListener(handleTextChange);
    phoneNumberController.addListener(handleTextChange);
    latController.addListener(handleTextChange);
    lngController.addListener(handleTextChange);
  }

  void handleTextChange() {
    // Check if any text field has changed
    if (mosqueController.text !=  widget.mosque['mosque'] ||
        locationController.text != widget.mosque['location'] ||
        addressController.text != widget.mosque['address'] ||
        phoneNumberController.text != widget.mosque['phoneNumber'] ||
    latController.text != widget.mosque['latlng'].latitude.toString() ||
    lngController.text != widget.mosque['latlng'].longitude.toString()

    ) {
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
      appBar: AppBar(
        title: Text("${widget.mosque['mosque']}"),
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
            colors: [Color(0xffC5DFF1), Colors.white],  // You can customize the colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              Container(
                height: 250.h,
                width: 150.w,
                decoration: BoxDecoration(              borderRadius: BorderRadius.circular(15.0.r),
                    image: DecorationImage(
                    image: NetworkImage(widget.mosque['image']),
                fit: BoxFit.cover,
              ),)
              ),
              ReuseTextFields(
                prefixicon: Icons.mosque,
                controller: mosqueController,
                text: 'Mosque Name',
                hintText: 'Mosque Name',
              ),
              ReuseTextFields(
                prefixicon: Icons.location_on_outlined,
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
              ReuseTextFields(
                text: 'Latitude',
                hintText: "50",
                prefixicon: Icons.language,
                controller: latController,
              ),
              ReuseTextFields(
                text: 'Longitude',
                hintText: "71",
                prefixicon: Icons.location_on_outlined,
                controller: lngController,
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(100.w, 50.h),
                    backgroundColor: Colors.black54

                ),
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
                      'latlng': GeoPoint(
                        double.parse(latController.text),
                        double.parse(lngController.text),
                      ),
                    }, SetOptions(merge: true));
                    widget.mosque['mosque']=mosqueController.text;
                    widget.mosque['location']=locationController.text;
                    widget.mosque['address']=addressController.text;
                    widget.mosque['phoneNumber']=phoneNumberController.text;
                    widget.mosque['latlng'] = GeoPoint(
                      double.parse(latController.text),
                      double.parse(lngController.text),
                    );
                    Get.snackbar('Success', 'Mosque Data has been updated');





                  } catch (e) {
                    print(e);
                  }
                }
                    : null,
                child: Text("Update Mosque",style: TextStyle(color: isButtonEnabled?Colors.white:Colors.black54),),
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
    latController.dispose();
    lngController.dispose();
    super.dispose();
  }
}
