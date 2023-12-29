import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'dart:developer';

class AuthServices {
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
    } catch (e) {
      toastMessage('Error');
      return false;
    }
  }

  static Future<void> storeAdminDetails({
    required AdminModel adminModel,
  }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference user = firestore
          .collection('adminDetails')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      Map<String, dynamic> adminData = adminModel.toMap();
      await user.set(adminData);
    } catch (e) {
      log('Error storing admin details: ${e.toString()}');
    }
  }

  static Future<AdminModel?> fetchAdminDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('adminDetails')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> mapData = documentSnapshot.data()!;
        return AdminModel.fromMap(mapData);
      } else {
        return null;
      }
    } catch (e) {
      log('Error fetching admin details: ${e.toString()}');
      return null;
    }
  }

  static Future<void> deleteImageUrl() async {
    try {
      await FirebaseFirestore.instance
          .collection('adminDetails')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'image_url': FieldValue.delete(),
      });
      toastMessage('Deleted Successfully');
    } catch (e) {
      log('Error deleting imageUrl: ${e.toString()}');
    }
  }

  static Future<void> storeAdminData(
      {required String email, required controller}) async {
    try {
      DocumentReference users =
          FirebaseFirestore.instance.collection('adminData').doc(controller);
      await users.set({'email': email});
    } catch (e) {
      log('Error : ${e.toString()}');
    }
  }

  static Future<Map<String, dynamic>> fetchAdminData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('adminData').get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> mapData = querySnapshot.docs.first.data();
        return mapData;
      } else {
        return {};
      }
    } catch (e) {
      log('Error fetching admin data: $e');

      return {};
    }
  }
}
