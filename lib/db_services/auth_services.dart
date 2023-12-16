import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guitar_songs/utlis/app_routes.dart';
import 'package:guitar_songs/utlis/toast.dart';

class AuthServices {
  static Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context).pushNamed(AppRoutes.progressManagement);
      } else {
        print('Not Login');
      }
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  static Future<void> admin({
    required String email,
    required TextEditingController controller,
    required String password,
 
  }) async {
    try {
      DocumentReference users =
          FirebaseFirestore.instance.collection('admin').doc(controller.text);
      await users.set({
        'email': email,
        'password': password,
      });
    } catch (e) {
      print('Error : ${e.toString()}');
    }
  }

static Future<void> adminData({
    required String email,
    required TextEditingController controller,
    required String username,
 required String lastName,
 required String firstName,
 required String phoneNo,
 required String address,
  }) async {
    try {
      DocumentReference users =
          FirebaseFirestore.instance.collection('adminDetails').doc(controller.text);
      await users.set({
        'email': email,
        'username':username,
        'firstName':firstName,
        'lastName':lastName,
        'phoneNo':phoneNo,
        'address':address
      
      });
    } catch (e) {
      print('Error : ${e.toString()}');
    }
  }

}
