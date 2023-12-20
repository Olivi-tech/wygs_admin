import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guitar_songs/model/model.dart';

class ScreensServices {
  static Stream<List<BillingModel>> fetchBillingManagement() {
    return FirebaseFirestore.instance
        .collection('billingManagement')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> event) {
      return event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return BillingModel.fromMap(doc.data());
      }).toList();
    });
  }

  static Stream<List<ProgressModel>> fetchProgressManagement() {
    return FirebaseFirestore.instance
        .collection('progressManagement')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> event) {
      return event.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return ProgressModel.fromMap(doc.data());
      }).toList();
    });
  }

  static Stream<List<GuestModel>> fetchGuestManagement() {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection('guestManagement').snapshots();
    return stream.map((map) {
      return map.docs.map((doc) {
        return GuestModel.fromMap(doc.data());
      }).toList();
    });
  }

  static Stream<List<CommunityModel>> fetchCommunityManagement() {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
        .instance
        .collection('communityManagement')
        .snapshots();
        return stream.map((event) {
        return event.docs.map((doc) {
          return CommunityModel.fromMap(doc.data());
        }).toList();
        });
  }
}
