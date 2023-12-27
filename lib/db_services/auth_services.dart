import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'dart:developer';

class AuthServices {
  static Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        toastMessage('Successfully SignIn');
        Future.delayed(const Duration(milliseconds: 500))
            .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.progressManagement,
                  (route) => false,
                ));
      } else {
        log('Not Login');
      }
    }).onError((error, stackTrace) {
      toastMessage('Error');
    });
  }

  static Future<void> storeAdminDetails(
      {required AdminModel adminModel}) async {
    try {
      DocumentReference users = FirebaseFirestore.instance
          .collection('adminDetails')
          .doc(adminModel.userName);
      await users.set(adminModel.toMap());
    } catch (e) {
      log('Error : ${e.toString()}');
    }
  }

  static Future<void> updateAdminDetails(
      {required AdminModel adminModel}) async {
    try {
      DocumentReference users = FirebaseFirestore.instance
          .collection('adminDetails')
          .doc(adminModel.userName);
      await users.update(adminModel.toMap());
    } catch (e) {
      log('Error : ${e.toString()}');
    }
  }

  static Future<AdminModel?> fetchAdminDetails() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('adminDetails')
        .orderBy('user_name', descending: false)
        .limit(1)
        .get();
    Map<String, dynamic> mapData = querySnapshot.docs.first.data();
    return AdminModel.fromMap(mapData);
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
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('adminData').get();
    Map<String, dynamic> mapData = querySnapshot.docs.first.data();
    return mapData;
  }
}
