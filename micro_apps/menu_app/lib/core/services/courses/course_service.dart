import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_app/core/services/firebase/firebase_storage_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/utils/logger/logger.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final log = CustomLogger.getLogger('CourseService');

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
          batchDay: formData['batchDay'] ?? '',
          batchTime: formData['batchTime'] ?? '',
          amount: double.parse(formData['amount']),
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
