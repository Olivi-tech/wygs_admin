
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreServices {
  // static Stream<List<BillingModel>> fetchBillingManagement() {
  //   return FirebaseFirestore.instance
  //       .collection('billingManagement')
  //       .snapshots()
  //       .map((QuerySnapshot<Map<String, dynamic>> event) {
  //     return event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
  //       return BillingModel.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

//  static Future<void> deleteBillingData() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('billingManagement')
//           .doc()
//           .delete()
//           .then((value) => Utlis().toastMessage('Data Deleted Successfully'));
//     } catch (e) {
//       log('Error deleting billing data: $e');
//     }
//   }

  // static Stream<List<UserModel>> fetchUserManagement() {
  //   return FirebaseFirestore.instance
  //       .collection('userManagement')
  //       .snapshots()
  //       .map((QuerySnapshot<Map<String, dynamic>> event) {
  //     return event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
  //       return UserModel.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

  // static Stream<List<GuestModel>> fetchGuestManagement() {
  //   Stream<QuerySnapshot<Map<String, dynamic>>> stream =
  //       FirebaseFirestore.instance.collection('guestManagement').snapshots();
  //   return stream.map((map) {
  //     return map.docs.map((doc) {
  //       return GuestModel.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

  // static Stream<List<CommunityModel>> fetchCommunityManagement() {
  //   Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
  //       .instance
  //       .collection('communityManagement')
  //       .snapshots();
  //   return stream.map((event) {
  //     return event.docs.map((doc) {
  //       return CommunityModel.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

  // static Stream<List<ProgressModel>> fetchProgressManagement(
  //     {String? searchItems}) {
  //   Stream<QuerySnapshot<Map<String, dynamic>>> stream =
  //       FirebaseFirestore.instance.collection('progressManagement').snapshots();
  //   return stream.map((event) {
  //     return event.docs.map((doc) {
  //       return ProgressModel.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

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
