import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:trendhub/Models/UserModels.dart';
import 'package:trendhub/constant/constant.dart';
import 'package:trendhub/functions/databasecollection.dart';
import 'package:trendhub/utils/DeletAccount.dart';
import 'package:trendhub/utils/logout.dart';

class Profile extends StatefulWidget {
  UserModel? user = UserModel();
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User? userinfo;
  PlatformFile? pickedfile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      pickedfile = result?.files.first;
    });
  }

  Future uploadFile() async {
    if (pickedfile == null) {
      return;
    }
    final path = '${widget.user!.userEmail}/image/${pickedfile!.name}';
    final file = File(pickedfile!.path ?? '');
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download $urlDownload');
    setState(() {
      widget.user!.userImage = urlDownload;
      updateUserImage(urlDownload, widget.user!.userEmail);
    });
  }

  Future uploadFileBackground() async {
    if (pickedfile == null) {
      return;
    }
    final path = '${widget.user!.userEmail}/background/${pickedfile!.name}';
    final file = File(pickedfile!.path ?? '');
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download $urlDownload');
    setState(() {
      widget.user!.userImage = urlDownload;
      updateUserImage(urlDownload, widget.user!.userEmail);
    });
  }

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    try {
      userinfo = FirebaseAuth.instance.currentUser;

      if (userinfo != null) {
        var docRef = await FirebaseFirestore.instance
            .collection('Accounts')
            .doc(userinfo!.email)
            .get();

        print('Document data: ${docRef.data()}');

        if (docRef.exists) {
          setState(() {
            widget.user!.userName =
                docRef.data()?['userName']?.toString() ?? '';
            widget.user!.userEmail =
                docRef.data()?['userEmail']?.toString() ?? '';
            widget.user!.userImage =
                docRef.data()?['userImage']?.toString() ?? '';
            widget.user!.userBagroundImage =
                docRef.data()?['userBackgroundImage']?.toString();
          });
        } else {
          print('Document does not exist');
        }
      } else {
        print('User is null');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 25, letterSpacing: 3.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    selectFile();
                    uploadFileBackground();
                  },
                  child: Container(
                    width: screenWidth,
                    height: screenWidth * 0.4,
                    child: Image.network(widget.user!.userBagroundImage ??
                        Constant.backgroundimageurl),
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: screenWidth * 0.7,
                ),
                Positioned(
                    bottom: 50,
                    left: screenWidth * 0.36,
                    child: GestureDetector(
                      onTap: () {
                        selectFile();
                        uploadFile();
                      },
                      child: CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            widget.user!.userImage ?? Constant.imageUrl),
                      ),
                    )),
              ],
            ),

            // Other Profile Information
            const SizedBox(height: 20),
            Text(
              '${widget.user!.userName}',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.user!.userEmail}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            LogOut(context),
            const SizedBox(height: 20),
            DeletAccount(context),
          ],
        ),
      ),
    );
  }
}
