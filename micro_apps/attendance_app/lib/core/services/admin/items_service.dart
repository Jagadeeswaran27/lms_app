import 'package:attendance_app/models/courses/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendance_app/utils/logger/logger.dart';

class ItemsService {
  ItemsService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final ItemsService _instance = ItemsService._privateConstructor();

  // Factory constructor to return the static instance
  factory ItemsService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CourseModel>> getCourses(String instituteId) async {
    try {
      // Step 1: Query the courses collection within the specific institute
      QuerySnapshot coursesSnapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('courses')
          .get();

      // Step 2: Convert the snapshot data to a list of CourseModel
      List<CourseModel> courses = [];
      for (var doc in coursesSnapshot.docs) {
        // Fetch the course data
        Map<String, dynamic> courseData = doc.data() as Map<String, dynamic>;

        // Fetch the number of registrations for this course
        QuerySnapshot registrationSnapshot = await _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('students-registrations')
            .where('courseId', isEqualTo: courseData['courseId'])
            .get();

        // Extract user names from the registrations
        List<String> userNames = registrationSnapshot.docs
            .map((registrationDoc) => registrationDoc['userName'] as String)
            .toList();

        int noOfRegistrations = registrationSnapshot.size;

        // Add the number of registrations to the course data
        courseData['noOfRegistrations'] = noOfRegistrations;
        courseData['students'] = userNames;

        // Convert the course data to an CourseModel and add it to the list
        courses.add(CourseModel.fromJson(courseData));
      }

      return courses;
    } catch (e) {
      log.e('Error fetching courses: $e');
      return [];
    }
  }
}
