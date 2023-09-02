import 'package:cloud_firestore/cloud_firestore.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<Map<String, dynamic>> fetchUserDetails(String uid) async {
  try {
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      return userData;
    } else {
      print('User not found');
      return {};
    }
  } catch (e) {
    print('Error fetching user details: $e');
    return {};
  }
}