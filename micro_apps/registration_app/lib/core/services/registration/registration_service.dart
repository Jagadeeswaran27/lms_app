import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/models/registration/student_registration_model.dart';
import 'package:registration_app/models/registration/teacher_registration_model.dart';

class RegistrationService {
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

  Future<List<String>> registerStudent({
    required List<CourseModel> courses,
    required String selectedBatchDay,
    required String selectedBatchTime,
    required String registeredBy,
    required String email,
    required String userName,
    required String mobileNumber,
    required String registeredFor,
  }) async {
    try {
      // Get the first institute ID
      final QuerySnapshot instituteSnapshot =
          await _firestore.collection('institutes').limit(1).get();
      if (instituteSnapshot.docs.isEmpty) {
        return [];
      }

      final String instituteId = instituteSnapshot.docs.first.id;

      // Create a list to store registration IDs
      List<String> registrationIds = [];

      // Loop through each course in the courses list
      for (CourseModel course in courses) {
        // Generate a unique registration ID for each course
        final DocumentReference courseRegistrationRef = _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('students-registrations')
            .doc();
        final String courseRegistrationId = courseRegistrationRef.id;

        // Create StudentRegistrationModel for each course
        final StudentRegistrationModel registration = StudentRegistrationModel(
          courseName: course.courseTitle,
          courseId: course.courseId,
          registrationId: courseRegistrationId,
          registeredBy: registeredBy,
          status: 'Pending',
          paymentStatus: 'Unpaid',
          imageUrl: course.imageUrl,
          registeredFor: registeredFor,
          batchDay: selectedBatchDay,
          batchTime: selectedBatchTime,
          email: email,
          userName: userName,
          mobileNumber: mobileNumber,
        );

        // Store the registration in Firestore
        await _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('students-registrations')
            .doc(courseRegistrationId)
            .set(registration.toJson());

        // Add the course ID to the user's registered courses in Firestore
        await _firestore.collection('lms-users').doc(registeredBy).update({
          'registeredCourses': FieldValue.arrayUnion([course.courseId])
        });

        // Add the registration ID to the list
        registrationIds.add(courseRegistrationId);
      }

      // Return all registration IDs as a comma-separated string
      return registrationIds;
    } catch (e) {
      print('Error registering teacher: $e');
      throw Exception('Failed to register teacher');
    }
  }
}
