import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayertime_dashboard/controllers/prayers_controller.dart';

PrayersController prayersController = Get.put(PrayersController());

class MosqueController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController mosqueController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    await fetchMosques();
    super.onInit();
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    mosqueController.dispose();
    locationController.dispose();
    phoneController.dispose();
    addressController.dispose();
    websiteController.dispose();
    latController.dispose();
    lngController.dispose();

    super.dispose();
  }

  Future<void> AddMosque() async {
    try {
      if (mosqueController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          locationController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          websiteController.text.isNotEmpty &&
          imageController.text.isNotEmpty &&
          latController.text.isNotEmpty &&
          lngController.text.isNotEmpty &&
          prayersController.ishajammahTimecontroller.text.isNotEmpty) {
        // Convert latitude and longitude values to double
        double latitude = double.parse(latController.text);
        double longitude = double.parse(lngController.text);

        // Create GeoPoint
        GeoPoint latLng = GeoPoint(latitude, longitude);

        DocumentReference docRef =
            await firestore.collection('prayerTimes').add({
          'mosque': mosqueController.text,
          'location': locationController.text,
          'phoneNumber': phoneController.text,
          'address': addressController.text,
          'website': websiteController.text,
          'latlng': latLng,
          'image': imageController.text,
          'prayers': [],
        });
        // Update the document with its own ID
        await docRef.update({'docId': docRef.id});
        prayersController.addprayers(docRef.id);

        Get.snackbar("Sucess", "Mosque has been added");

        // Clear the text fields after adding the mosque
        mosqueController.clear();
        locationController.clear();
        phoneController.clear();
        addressController.clear();
        websiteController.clear();
        latController.clear();
        lngController.clear();
        fetchMosques();
      } else {
        Get.snackbar("Can't Add Data", "Enter All Fields");
      }
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  List<Map<String, dynamic>> mosques = [];

  Future<void> fetchMosques() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('prayerTimes').get();

      mosques = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Now, mosques list contains the data from Firestore
      print("Mosques fetched");
    } catch (e) {
      print('Error fetching mosques data: $e');
    } finally {
      update();
    }
  }

  void deleteMosque(String id) async {
    try {
      await firestore.collection('prayerTimes').doc(id).delete();
      fetchMosques();
      Get.snackbar('Success', "Mosque Has been deleted");
    } catch (e) {
      print(e);
    }
  }

  // Add a variable to store the search query
  RxString searchQuery = ''.obs;

  // Use a computed property to get filtered mosques based on the search query
  List<Map<String, dynamic>> get filteredMosques {
    if (searchQuery.isEmpty) {
      return mosques;
    } else {
      return mosques
          .where((mosque) =>
              mosque['mosque']
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              mosque['location']
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  // Update the searchQuery
  void updateSearchQuery(String value) {
    searchQuery.value = value;
    update();
  }
}
