import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guitar_songs/model/model.dart';

class FirestoreServices {
  static Stream<List<T>> fetchCollectionData<T>(
      String collectionName, T Function(Map<String, dynamic>) fromMap) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('days')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> event) {
      return event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return fromMap(doc.data());
      }).toList();
    });
  }

  
 static Stream<List<FaqModel>> fetchProgressUserDays(String documentId) {
    return FirebaseFirestore.instance
        .collection('users_progress')
        .doc(documentId)
        .collection('days')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> event) {
      return event.docs.map((doc) {
        return FaqModel.fromMap(doc.data());
      }).toList();
    });
  }
  static Future<void> deleteProgressUserData(String userId) async {
    var daysCollection = FirebaseFirestore.instance
        .collection('users_progress')
        .doc(userId)
        .collection('days');
    // Delete documents in 'days' collection
    var dayQuerySnapshot = await daysCollection.get();
    for (var dayDoc in dayQuerySnapshot.docs) {
      await daysCollection.doc(dayDoc.id).delete();

      // Delete the user progress document
      await FirebaseFirestore.instance
          .collection('users_progress')
          .doc(userId)
          .delete();
    }
  }
static Stream<List<T>> fetchUserCollectionData<T>(String collectionName , T Function(Map<String,dynamic> data, String id) fromMap) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> event) {
      return event.docs.map((doc) {
        return fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  static Future<void> deleteUserCollection<T>(String collectionName) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionName);
    QuerySnapshot querySnapshot = await collectionReference.get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<void> deleteUserDocument<T>(
      String userId, String collectionName) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionName);
    await collectionReference.doc(userId).delete();
  }

 

  static Future<int> fetchCommunityDataLength() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('community_data').get();
    int length = querySnapshot.docs.length;
    return length;
  }
}
