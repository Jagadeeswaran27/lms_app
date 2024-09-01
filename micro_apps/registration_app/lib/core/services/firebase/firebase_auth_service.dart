import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:registration_app/constants/enums/user_role_enum.dart';
import 'package:registration_app/models/auth/user_model.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/utils/logger/logger.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Add this line
  final log = CustomLogger.getLogger('AuthService');
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Private constructor
  FirebaseAuthService._privateConstructor();

  // Static instance variable
  static final FirebaseAuthService _instance =
      FirebaseAuthService._privateConstructor();

  // Factory constructor to return the same instance
  factory FirebaseAuthService() {
    return _instance;
  }

  // Stream to listen to authentication state changes
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      throw Exception(Strings.invalidCredentials);
    } catch (e) {
      throw Exception(Strings.anErrorOccurred);
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
    String phone,
    String role,
    String instituteId,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // final bool isInstitute =
      //     role == UserRoleEnum.institute.roleName ? true : false;
      await _firestore
          .collection('lms-users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'name': userName,
        'email': email,
        'role': role,
        'phone': phone,
        // 'institute': isInstitute ? [instituteId] : [],
      });
      if (role == UserRoleEnum.institute.roleName) {
        await _firestore.collection('institutes').doc(instituteId).set({
          'uid': instituteId,
          'email': email,
          'instituteId': instituteId,
          'instituteName': userName,
        });
      }
      return userCredential;
    } on FirebaseAuthException {
      log.e('Error signing up: ');
      throw Exception(Strings.invalidCredentials);
    } catch (e) {
      throw Exception(Strings.anErrorOccurred);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  // Sign out
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      log.e('Error signing out: $e');
      return false;
    }
  }

  // Fetch user role from Firestore
  Future<String> getUserRole(User user) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('lms-users').doc(user.uid).get();
      if (doc.exists) {
        return doc['role'] ?? 'student';
      } else {
        return 'student'; // default role if no data found
      }
    } catch (e) {
      log.e('Error fetching user role: $e');
      rethrow;
    }
  }

  // Fetch user from Firebase
  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('lms-users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      log.e('Error fetching user: $e');
      rethrow;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      log.e("Error sending password reset email: $e");
      return false;
    }
  }

  Future<User?> changeUserPassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: oldPassword);
        UserCredential newUserCredential =
            await user.reauthenticateWithCredential(credential);
        await newUserCredential.user!.updatePassword(newPassword);
        return newUserCredential.user;
      } else {
        log.e("No user is currently signed in.");
        return null;
      }
    } catch (e) {
      log.e("Error resetting password: $e");
      return null;
    }
  }

  Future<bool> doesInstituteExist(String instituteId) async {
    try {
      DocumentSnapshot instituteDoc =
          await _firestore.collection('institutes').doc(instituteId).get();
      return instituteDoc.exists;
    } catch (e) {
      log.e('Error checking institute existence: $e');
      return false;
    }
  }

  Future<String> createLMSUser(
      String uid, String name, String email, String role, String phone) async {
    try {
      await _firestore.collection('lms-users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'role': role,
        'phone': phone,
      });
      return uid;
    } catch (e) {
      log.e('Error creating LMS user: $e');
      return '';
    }
  }
}
