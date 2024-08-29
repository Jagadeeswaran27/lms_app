import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_app/models/enquiry/enquiry_model.dart';
import 'package:menu_app/utils/logger/logger.dart';

class EnquiryService {
  EnquiryService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final EnquiryService _instance = EnquiryService._privateConstructor();

  // Factory constructor to return the static instance
  factory EnquiryService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<EnquiryModel>> getEnquiries(String userId) async* {
    try {
      // Get the first institute document
      QuerySnapshot snapshot =
          await _firestore.collection('institutes').limit(1).get();

      String instituteId = snapshot.docs.first.id;

      // Create a stream of enquiries
      Stream<QuerySnapshot> enquiriesStream = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('enquiries')
          .where("status", isNotEqualTo: "resolved")
          .snapshots();

      // Yield enquiries as they come in
      await for (QuerySnapshot querySnapshot in enquiriesStream) {
        List<EnquiryModel> enquiries = querySnapshot.docs.map((doc) {
          return EnquiryModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        yield enquiries;
      }
    } catch (e) {
      log.e('Error fetching user enquiries: $e');
      yield [];
    }
  }

  Future<bool> resolveEnquiry(String enquiryId) async {
    try {
      // Get the first institute document
      QuerySnapshot snapshot =
          await _firestore.collection('institutes').limit(1).get();

      String instituteId = snapshot.docs.first.id;

      // Update the enquiry status to "resolved"
      await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('enquiries')
          .doc(enquiryId)
          .update({'status': 'resolved'});

      log.i('Enquiry $enquiryId resolved successfully');
      return true;
    } catch (e) {
      log.e('Error resolving enquiry: $e');
      return false;
    }
  }
}
