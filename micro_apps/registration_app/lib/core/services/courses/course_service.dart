import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/utils/logger/logger.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final log = CustomLogger.getLogger('CourseService');

  Stream<List<CourseModel>> getCourses() async* {
    try {
      QuerySnapshot qSnapshot =
          await _firestore.collection('institutes').limit(1).get();
      if (qSnapshot.docs.isEmpty) {
        yield [];
        return;
      }
      String instituteId = qSnapshot.docs.first.id;
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