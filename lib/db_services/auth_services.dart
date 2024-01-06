import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'dart:developer';

class AuthServices {
static User? get getCurrentUser{
   return FirebaseAuth.instance.currentUser;
}

  static Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.homeScreen,
            (route) => false,
          );
        });
        return true;
      } else {
        log('Not Login');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastMessage('No user found for that email.');

        return false;
      } else if (e.code == 'wrong-password') {
        toastMessage('Wrong password provided for that user.');

        return false;
      }
      return false;
    }
  }

  static Future<void> storeAdminDetails({
    required AdminModel adminModel,
  }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference user = firestore
          .collection('admin_data')
          .doc(getCurrentUser!.uid);
      Map<String, dynamic> adminData = adminModel.toMap();
      await user.update(adminData);
    } catch (e) {
      log('Error storing admin data: ${e.toString()}');
    }
  }

  static Future<AdminModel?> fetchAdminDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('admin_data')
              .doc(getCurrentUser!.uid)
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> mapData = documentSnapshot.data()!;
        return AdminModel.fromMap(mapData);
      } else {
        return null;
      }
    } catch (e) {
      log('Error fetching admin data: ${e.toString()}');
      return null;
    }
  }

  static Future<void> deleteImageUrl() async {
    try {
      await FirebaseFirestore.instance
          .collection('admin_data')
          .doc(getCurrentUser!.uid)
          .update({
        'image_url': FieldValue.delete(),
      });
      toastMessage('Deleted Successfully');
    } catch (e) {
      log('Error deleting imageUrl: ${e.toString()}');
    }
  }

}
