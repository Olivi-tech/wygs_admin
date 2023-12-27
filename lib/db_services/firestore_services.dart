
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreServices {
  static Stream<List<T>> fetchCollectionData<T>(
    String collectionName, T Function(Map<String, dynamic>) fromMap) {
  return FirebaseFirestore.instance
      .collection(collectionName)
      .snapshots()
      .map((QuerySnapshot<Map<String, dynamic>> event) {
    return event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      return fromMap(doc.data());
    }).toList();
  });
}

}
