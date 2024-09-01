import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_app/core/services/firebase/firebase_storage_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/utils/logger/logger.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final log = CustomLogger.getLogger('CourseService');

  Future<String?> addCourse(
    Map<String, dynamic> formData,
    File imageFile,
    String instituteId,
  ) async {
    try {
      final courseId = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('courses')
          .doc()
          .id;
      String imageUrl = await _storageService.uploadFile(
          imageFile, 'institutes/$instituteId', '$courseId.jpg');

      // Create a new course with the image URL
      CourseModel newCourse = CourseModel(
        courseId: courseId,
        courseTitle: formData['itemTitle'],
        imageUrl: imageUrl,
        shortDescription: formData['shortDescription'],
        aboutDescription: formData['aboutDescription'],
        batchDay: formData['batchDay'],
        batchTime: formData['batchTime'],
        amount: double.parse(formData['amount']),
        courseTeacher: '',
      );

      // Add the course to Firestore
      await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('courses')
          .doc(courseId)
          .set(newCourse.toJson());

      log.i('Course added successfully');
      return courseId;
    } catch (e) {
      throw Exception('Failed to add course');
    }
  }

  Stream<List<CourseModel>> getCourses(String instituteId) async* {
    try {
      yield* _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('courses')
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) =>
                CourseModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      log.e('Error getting courses: $e');
      throw Exception('Failed to get courses');
    }
  }
}
