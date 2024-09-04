import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_app/core/services/firebase/firebase_storage_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/utils/logger/logger.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final log = CustomLogger.getLogger('CourseService');

  Future<String?> hasSelectedCategory(String accessCode) async {
    try {
      DocumentReference instituteDocRef =
          _firestore.collection('institutes').doc(accessCode);

      DocumentSnapshot instituteDoc = await instituteDocRef.get();

      if (instituteDoc.exists) {
        Map<String, dynamic>? data =
            instituteDoc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('selectedCategory')) {
          return data['selectedCategory'] as String;
        }
      }
      return null;
    } catch (e) {
      print(e);
      log.e('Error checking selectedCategory: $e');
      throw Exception('Failed to check selectedCategory');
    }
  }

  Future<String?> addItem(
    Map<String, dynamic> formData,
    File imageFile,
    String accessCode,
    String subCategory,
  ) async {
    try {
      String imageUrl = await _storageService.uploadFile(imageFile,
          'institutes/$accessCode', '${imageFile.path.split('/').last}.jpg');

      final itemTitles =
          formData['itemTitle'].split(',').map((e) => e.trim()).toList();
      String? lastAddedItemId;
      // Check if the selectedCategory field exists in the document
      DocumentReference instituteDocRef =
          _firestore.collection('institutes').doc(accessCode);

      DocumentSnapshot instituteDoc = await instituteDocRef.get();

      // Check if the document exists and if the selectedCategory field is present
      if (instituteDoc.exists) {
        Map<String, dynamic>? data =
            instituteDoc.data() as Map<String, dynamic>?;
        if (data == null || !data.containsKey('selectedCategory')) {
          // If selectedCategory field doesn't exist, add it
          await instituteDocRef.update({
            'selectedCategory': subCategory,
          });
          log.i(
              'selectedCategory set to "$subCategory" for institute "$accessCode"');
        }
      }
      for (String itemTitle in itemTitles) {
        final itemId = _firestore
            .collection('institutes')
            .doc(accessCode)
            .collection(subCategory)
            .doc()
            .id;

        CourseModel newCourse = CourseModel(
          courseId: itemId,
          courseTitle: itemTitle,
          imageUrl: imageUrl,
          shortDescription: formData['shortDescription'],
          aboutDescription: formData['aboutDescription'],
          batchDay: formData['batchDay'] ?? [],
          batchTime: formData['batchTime'] ?? '',
          amount: double.parse(formData['amount']),
          totalHours: int.parse(formData['totalHours']),
        );

        await _firestore
            .collection('institutes')
            .doc(accessCode)
            .collection(subCategory)
            .doc(itemId)
            .set(newCourse.toJson()
              ..removeWhere((key, value) => value == null || value == ''));

        log.i('Item "$itemTitle" added successfully');
        lastAddedItemId = itemId;
      }
      return lastAddedItemId;
    } catch (e) {
      print(e);
      throw Exception('Failed to add item');
    }
  }

  Stream<List<CourseModel>> getItems(
      String accessCode, String subCategory) async* {
    try {
      yield* _firestore
          .collection('institutes')
          .doc(accessCode)
          .collection(subCategory)
          .snapshots()
          .map((querySnapshot) {
        print(querySnapshot.docs.length);
        return querySnapshot.docs
            .map((doc) =>
                CourseModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      log.e('Error getting items: $e');
      throw Exception('Failed to get items');
    }
  }
}
