import 'package:attendance_app/models/courses/attendance_model.dart';
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

  Future<List<CourseModel>> getCourses(
      String userId, String instituteId) async {
    try {
      // Step 1: Fetch the user document
      DocumentSnapshot userSnapshot =
          await _firestore.collection('lms-users').doc(userId).get();

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

  Future<bool> markAttendance(
    Map<String, bool> attendanceStatus,
    String courseId,
    String date,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      for (var entry in attendanceStatus.entries) {
        String studentId = entry.key;
        bool status = entry.value;

        // Create an instance of AttendanceModel
        AttendanceModel attendanceModel = AttendanceModel(status: status);

        // Convert the model to a map
        Map<String, dynamic> attendanceData = attendanceModel.toJson();

        // Define the path to the document
        DocumentReference attendanceDocRef = firestore
            .collection('lms-users')
            .doc(studentId)
            .collection('courses')
            .doc(courseId)
            .collection('attendance')
            .doc(date);

        // Add or update the document with the attendance data
        await attendanceDocRef.set(attendanceData);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map<String, bool>> getAttendance(
    String courseId,
    String date,
    Map<String, bool> attendanceStatus,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Create a map to hold student IDs and their attendance status
      Map<String, bool> attendanceMap = {};

      // Iterate through the student IDs in attendanceStatus map
      for (var studentId in attendanceStatus.keys) {
        // Fetch the attendance document for the given courseId and date
        DocumentSnapshot attendanceDoc = await firestore
            .collection('lms-users')
            .doc(studentId)
            .collection('courses')
            .doc(courseId)
            .collection('attendance')
            .doc(date)
            .get();

        if (attendanceDoc.exists) {
          // Convert the document data to AttendanceModel
          AttendanceModel attendanceModel = AttendanceModel.fromJson(
            attendanceDoc.data() as Map<String, dynamic>,
          );

          // Add to the map
          attendanceMap[studentId] = attendanceModel.status;
        } else {
          // If no attendance record exists for this date, assume false (absent)
          attendanceMap[studentId] = false;
        }
      }

      return attendanceMap;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<int> getTotalHours(String accessId, String courseId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Define the path to the document
      DocumentSnapshot courseDoc = await firestore
          .collection('institutes')
          .doc(accessId)
          .collection('courses')
          .doc(courseId)
          .get();

      // Check if the document exists and return the totalHours field
      if (courseDoc.exists) {
        // Extract the totalHours field
        int totalHours =
            courseDoc.get('totalHours') ?? 0; // Default to 0 if not found
        return totalHours;
      } else {
        // Document does not exist
        print('Document does not exist');
        return 0;
      }
    } catch (e) {
      // Handle any errors
      print(e);
      return 0;
    }
  }

  Future<int> attendedHours(String userId, String courseId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Define the path to the attendance collection
      QuerySnapshot attendanceSnapshot = await firestore
          .collection('lms-users')
          .doc(userId)
          .collection('courses')
          .doc(courseId)
          .collection('attendance')
          .where('status', isEqualTo: true)
          .get();

      // Count the number of documents in the collection
      int documentCount = attendanceSnapshot.size;

      return documentCount;
    } catch (e) {
      // Handle any errors
      print(e);
      return 0;
    }
  }
}
