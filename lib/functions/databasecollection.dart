import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:trendhub/Models/ChatUser.dart';

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

createUserMessage(String userEmail, name) async {
  await FirebaseFirestore.instance.collection('users').doc(userEmail).set({
    'userName': name,
  });
  print('user is updated');
}

Future<List<ChatUsers>> fetchData() async {
  List<ChatUsers> res = [];
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    String userName = doc['userName'];

    ChatUsers user = ChatUsers(
      userName: userName,
    );
    res.add(user);
  }

  print(res);
  return res;
}
