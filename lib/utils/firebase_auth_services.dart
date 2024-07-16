// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:hire_me/models/user_model.dart';
// import 'package:hire_me/utils/toast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class FirebaseAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//
//   Future<User?> signUpWithEmailAndPassword(
//       String email, String password, String fullName, String mobile, String registerType) async {
//     try {
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//
//       User? user = credential.user;
//
//       if (user != null) {
//         await _fireStore.collection('users').doc(user.uid).set({
//           'email': email,
//           'fullName': fullName,
//           'mobile': mobile,
//           'registerType': registerType,
//           'createdAt': FieldValue.serverTimestamp(),
//         });
//         return user;
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         showToast(message: 'The email address is already in use.');
//       } else {
//         showToast(message: 'An error occurred: ${e.code}');
//       }
//     }
//     return null;
//   }
//
//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return credential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//         showToast(message: 'Invalid email or password.');
//       } else {
//         showToast(message: 'An error occurred: ${e.code}');
//       }
//     }
//     return null;
//   }
//
//   Future<UserModel?> getUserDetails() async {
//     final prefs = await SharedPreferences.getInstance();
//     final email = prefs.getString("email");
//     final snapshot = await _fireStore
//         .collection("users")
//         .where("email", isEqualTo: email)
//         .get();
//     final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
//     print("fullname is ${userData.fullName})");
//     return userData;
//   }
// }
