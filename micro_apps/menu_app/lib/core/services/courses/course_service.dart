import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_app/core/services/firebase/firebase_storage_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/models/courses/item_model.dart';
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
    List<File> imageFile,
    String accessCode,
    String subCategory,
  ) async {
    try {
      final itemTitles =
          formData['itemTitle'].split(',').map((e) => e.trim()).toList();
      // String imageUrl = await _storageService.uploadFile(
      //   imageFile,
      //   'institutes/$accessCode',
      //   '${imageFile.path.split('/').last}',
      // );
      List<String> imageUrls = [];
      for (int i = 0; i < imageFile.length; i++) {
        String url = await _storageService.uploadFile(
          imageFile[i],
          'institutes/$accessCode',
          '${imageFile[i].path.split('/').last}',
        );
        imageUrls.add(url);
      }

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
      WriteBatch batch = _firestore.batch();

      for (String itemTitle in itemTitles) {
        print('...................................');
        print(itemTitle);
        List batchDays = formData['batchDay'] ?? [];
        List batchTimes = formData['batchTime'] ?? [];
        int index = itemTitles.indexOf(itemTitle);

//Todo:If no batch days and batch times then different logic
        if (subCategory != 'courses') {
          final itemId = _firestore
              .collection('institutes')
              .doc(accessCode)
              .collection(subCategory)
              .doc()
              .id;

          ItemModel newItem = ItemModel(
            courseId: itemId,
            courseTitle: itemTitle,
            imageUrl: imageUrls[index],
            shortDescription: formData['shortDescription'],
            aboutDescription: formData['aboutDescription'],
            amount: double.parse(formData['amount']),
          );

          await _firestore
              .collection('institutes')
              .doc(accessCode)
              .collection(subCategory)
              .doc(itemId)
              .set(
                newItem.toJson(),
              );
          lastAddedItemId = itemId;
        }
        for (String day in batchDays) {
          for (String time in batchTimes) {
            final itemId = _firestore
                .collection('institutes')
                .doc(accessCode)
                .collection(subCategory)
                .doc()
                .id;
            CourseModel newCourse = CourseModel(
              courseId: itemId,
              courseTitle: itemTitle,
              imageUrl: imageUrls[index],
              shortDescription: formData['shortDescription'],
              aboutDescription: formData['aboutDescription'],
              batchDay: day,
              batchTime: time,
              totalHours: formData['totalHours'],
              amount: double.parse(formData['amount']),
            );

            // Add the write operation to the batch
            batch.set(
              _firestore
                  .collection('institutes')
                  .doc(accessCode)
                  .collection(subCategory)
                  .doc(itemId),
              newCourse.toJson()
                ..removeWhere((key, value) => value == null || value == ''),
            );
            lastAddedItemId = itemId;
          }
        }
      }

      await batch.commit();

      log.i('Batch write completed successfully for all items.');

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
        // Convert the querySnapshot to a list of CourseModel
        List<CourseModel> courses = querySnapshot.docs
            .map((doc) =>
                CourseModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        // Sort the list by courseTitle alphabetically, case-insensitively
        courses.sort((a, b) =>
            a.courseTitle.toLowerCase().compareTo(b.courseTitle.toLowerCase()));

        return courses;
      });
    } catch (e) {
      log.e('Error getting items: $e');
      throw Exception('Failed to get items');
    }
  }
}
