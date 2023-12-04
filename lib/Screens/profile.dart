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
import 'package:trendhub/utils/EdiitScreen.dart';
import 'package:trendhub/utils/Setting.dart'; // Assuming you have a Setting widget
import 'package:trendhub/utils/logout.dart';

class Profile extends StatefulWidget {
  UserModel? user = UserModel();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User? userinfo;
  PlatformFile? pickedfile;
  PlatformFile? pickedBackground;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      pickedfile = result?.files.first;
    });
  }

  Future selectFileBackground() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      pickedBackground = result?.files.first;
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
    setState(() {
      widget.user!.userImage = urlDownload;
      updateUserImage(urlDownload, widget.user!.userEmail);
    });
  }

  Future uploadFileBackground() async {
    if (pickedBackground == null) {
      return;
    }
    final path =
        '${widget.user!.userEmail}/background/${pickedBackground!.name}';
    final file = File(pickedBackground!.path ?? '');
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      widget.user!.userBagroundImage = urlDownload;
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
              fontSize: screenWidth * 0.07,
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectFileBackground();
                          uploadFileBackground();
                        },
                        child: Container(
                          width: double.infinity,
                          height: screenWidth * 0.4,
                          child: Image.network(
                            widget.user!.userBagroundImage ??
                                Constant.backgroundimageurl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: screenWidth * 0.7,
                      ),
                      Positioned(
                        bottom: screenWidth * 0.15,
                        left: screenWidth * 0.5 - 64,
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
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: screenWidth,
                    height: 1,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${widget.user!.userName}',
                    style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${widget.user!.userEmail}',
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EditScreen(context),
                      SettingsScreen(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LogOut(context),
                DeletAccount(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
