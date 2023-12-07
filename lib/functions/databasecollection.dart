import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

createUser(String userEmail, userName, userImage, userBackground) async {
  await FirebaseFirestore.instance.collection('Accounts').doc(userEmail).set({
    'userName': userName,
    'userEmail': userEmail,
    'userImage': userImage,
    'userBackgroundImage': userBackground,
    
  });
}

Future<void> updateUserImage(String image, userEmail) async {
  await FirebaseFirestore.instance
      .collection('Accounts')
      .doc(userEmail)
      .update({
    'userImage': image,
  });
}

Future<void> updateBagroundImage(String image, userEmail) async {
  await FirebaseFirestore.instance
      .collection('Accounts')
      .doc(userEmail)
      .update({
    'userBackgroundImage': image,
  });
}

deletUser() {
  FirebaseAuth.instance.currentUser!.delete();
}
