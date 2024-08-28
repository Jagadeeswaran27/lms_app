import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/utils/logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  AttendanceService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final AttendanceService _instance =
      AttendanceService._privateConstructor();

  // Factory constructor to return the static instance
  factory AttendanceService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CourseModel>> getCourses(String userId, String instId) async {
    try {
      // Step 1: Fetch the user document
      DocumentSnapshot userSnapshot =
          await _firestore.collection('lms-users').doc(userId).get();
      QuerySnapshot snapshot = await _firestore
          .collection('institutes')
          .limit(1) // Limit the query to get only the first document
          .get();

      String instituteId = snapshot.docs.first.id;
      if (userSnapshot.exists) {
        // Explicitly cast the data to a Map
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        // Step 2: Extract registeredCourses from user data
        List<String> registeredCourses =
            List<String>.from(userData['registeredCourses']);

        // Step 3: Fetch each course details
        List<CourseModel> courses = [];
        if (registeredCourses.isNotEmpty) {
          for (String courseId in registeredCourses) {
            DocumentSnapshot courseSnapshot = await _firestore
                .collection('institutes')
                .doc(instituteId)
                .collection('courses')
                .doc(courseId)
                .get();

            if (courseSnapshot.exists) {
              // Convert Firestore data to CourseModel
              courses.add(CourseModel.fromJson(
                  courseSnapshot.data() as Map<String, dynamic>));
            }
          }
        }
        return courses;
      } else {
        log.e('User with ID $userId does not exist.');
        return [];
      }
    } catch (e) {
      log.e('Error fetching courses: $e');
      return [];
    }
  }
}
