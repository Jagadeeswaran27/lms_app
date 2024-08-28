import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_app/core/services/firebase/firebase_storage_service.dart';
import 'package:menu_app/models/enquiry/enquiry_model.dart';
import 'package:menu_app/utils/logger/logger.dart';

class EnquiryService {
  EnquiryService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final EnquiryService _instance = EnquiryService._privateConstructor();
  static final FirebaseStorageService _firebaseStorage =
      FirebaseStorageService();

  // Factory constructor to return the static instance
  factory EnquiryService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createEnquiry(
    String issue,
    String subject,
    String description,
    String priority,
    String userId,
    String instId,
    String type,
    File? file,
  ) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('institutes')
          .limit(1) // Limit the query to get only the first document
          .get();

      String instituteId = snapshot.docs.first.id;

      String enquiryId = _firestore
          .collection('institutes')
          .doc(snapshot.docs.first.id)
          .collection('enquiries')
          .doc()
          .id;

      String? imageUrl;

      if (file != null) {
        imageUrl = await _firebaseStorage.uploadFile(
            file, 'institutes/$instituteId/enquiries/', enquiryId);
      }

      EnquiryModel enquiryModel = EnquiryModel(
        description: description,
        status: 'created',
        enquiryId: enquiryId,
        issue: issue,
        priority: priority,
        subject: subject,
        type: type,
        userId: userId,
        fileUrl: imageUrl,
      );

      await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('enquiries')
          .doc(enquiryId)
          .set(
        {
          ...enquiryModel.toJson(),
        },
      );
      return enquiryId;
    } catch (e) {
      log.e('Error creating ticket: $e');
      return null;
    }
  }

  Future<List<EnquiryModel>> getEnquiries(
    String userId,
    String instId,
  ) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('institutes')
          .limit(1) // Limit the query to get only the first document
          .get();

      String instituteId = snapshot.docs.first.id;

      // Query Firestore for enquiries with the matching userId
      QuerySnapshot querySnapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('enquiries')
          .where("status", isNotEqualTo: "resolved")
          .get();

      // Convert each document to EnquiryModel and return as a list
      List<EnquiryModel> enquiries = querySnapshot.docs.map((doc) {
        return EnquiryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return enquiries;
    } catch (e) {
      log.e('Error fetching user enquiries: $e');
      return [];
    }
  }
}
