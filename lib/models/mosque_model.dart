import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MosqueModel {
  String? doc_id;
  String? location;
  String? image;
  String? address;
  String? phoneNumber;
  String? website;
  String? mosque;
  List? prayers_times;
  GeoPoint? latlng;



  MosqueModel({
    this.doc_id = " ",
    this.location = " ",
    this.image = " ",
    this.address = " ",
    this.phoneNumber = " ",
    this.website = " ",
    this.mosque = " ",
    this.prayers_times = const [],
    this.latlng = const GeoPoint(0, 0),
  });

  factory MosqueModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MosqueModel(
        doc_id: data?['doc_id'] ?? "",
        location: data?['location'] ?? "",
        image: data?['image'] ?? "",
        address: data?['address'] ?? "",
        phoneNumber: data?['phoneNumber'] ?? "",
        website: data?['website'] ?? "",
        mosque: data?['mosque'] ?? "",
        prayers_times: data?['prayers'] ?? [],
        latlng: data?['latlng'] ?? GeoPoint(0.0, 0.0));
  }

  Map<String, dynamic> toFirestore() {
    return {
      "doc_id": doc_id,
      "location": location,
      "image": image,
      "address": address,
      "phoneNumber": phoneNumber,
      "website": website,
      "mosque": mosque,
      "prayers": prayers_times,
      "latlng": latlng,
    };
  }
}
