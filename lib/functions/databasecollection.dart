import 'package:cloud_firestore/cloud_firestore.dart';

createUser(String userEmail, userName) async {
  await FirebaseFirestore.instance.collection('Accounts').doc(userEmail).set({
    'userName': userName,
  });
}
