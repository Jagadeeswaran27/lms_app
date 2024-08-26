import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/models/registration/teacher_registration_model.dart';

class TeacherRegistrationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerTeacher({
    required CourseModel course,
    required String selectedBatchDay,
    required String selectedBatchTime,
    required String registeredBy,
  }) async {
    try {
      // Get the first institute ID
      final QuerySnapshot instituteSnapshot =
          await _firestore.collection('institutes').limit(1).get();
      if (instituteSnapshot.docs.isEmpty) {
        return '';
      }

      final String instituteId = instituteSnapshot.docs.first.id;

      // Generate a unique registration ID
      final DocumentReference registrationRef = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('teachers-registrations')
          .doc();
      final String registrationId = registrationRef.id;

      // Create TeacherRegistrationModel
      final TeacherRegistrationModel registration = TeacherRegistrationModel(
        courseName: course.courseTitle,
        courseId: course.courseId,
        registrationId: registrationId,
        registeredBy: registeredBy,
        status: 'Pending',
        paymentStatus: 'Unpaid',
        imageUrl: course.imageUrl,
        registeredFor: 'self',
      );

      // Store the registration in Firestore
      await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('teachers-registrations')
          .doc(registrationId)
          .set(registration.toJson());

      // Update the user's registered courses in Firestore
      await _firestore.collection('lms-users').doc(registeredBy).update({
        'registeredCourses': FieldValue.arrayUnion([course.courseId])
      });

      return registrationId;
    } catch (e) {
      print('Error registering teacher: $e');
      throw Exception('Failed to register teacher');
    }
  }
}
