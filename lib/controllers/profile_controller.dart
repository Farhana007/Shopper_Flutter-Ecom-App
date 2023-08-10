import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppers/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = "".obs;
  var profileImgLink = "";
  var isLoading = false.obs;

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // uploadProfileImage() async {
  //   var filename = basename(profileImgPath.value);
  //   var destination = 'images/${currentUser!.uid}/$filename';
  //   Reference ref = FirebaseStorage.instance.ref().child(destination);
  //   await ref.putFile(File(profileImgPath.value));
  //   profileImgLink = await ref.getDownloadURL();
  // }
  uploadProfileImage() async {
    if (profileImgPath.value.isNotEmpty) {
      var file = File(profileImgPath.value);
      if (file.existsSync()) {
        var filename = basename(profileImgPath.value);
        var destination = 'images/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(file);
        profileImgLink = await ref.getDownloadURL();
      } else {
        print('Error: File not found at path: ${profileImgPath.value}');
      }
    } else {
      print('Error: Empty profileImgPath');
    }
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set(
        {
          'name': name,
          'password': password,
          'imageUrl': imgUrl,
        },
        SetOptions(
          merge: true,
        ));
    isLoading(false);
  }

  changeAuthPassword(
      {email,
      TextEditingController? password,
      TextEditingController? newpassword}) async {
    final cred =
        EmailAuthProvider.credential(email: email, password: password!.text);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword!.text);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
