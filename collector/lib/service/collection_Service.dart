import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDailyCollection(
      String farmerId, String date, String amount, String expectedPrice, String vegetable) async {
    try {
      // Reference to the "Daily Collection" sub-collection
      CollectionReference dailyCollection = _firestore
          .collection('farmer')
          .doc(farmerId)
          .collection('Daily Collection');

      // Add a new document to the "Daily Collection" sub-collection
      await dailyCollection.add({
        'CollectedDate': date,
        'amount': amount,
        'expectedPrice': expectedPrice,
        'vege': vegetable,
      });

      print('Daily Collection added successfully');
    } catch (e) {
      print('Error adding daily collection: $e');
    }
  }

 

  Future<List<Map<String, dynamic>>> getDailyCollections(String farmerId) async {
  List<Map<String, dynamic>> dailyCollectionList = [];

  try {
    CollectionReference dailyCollection = _firestore
        .collection('farmer')
        .doc(farmerId)
        .collection('Daily Collection');

    QuerySnapshot querySnapshot = await dailyCollection.get();

    for (var doc in querySnapshot.docs) {
      dailyCollectionList.add({
        'id': doc.id, // Add the document ID to the map
        ...doc.data() as Map<String, dynamic>
      });
    }

    print('Daily Collections retrieved successfully');
  } catch (e) {
    print('Error retrieving daily collections: $e');
  }

  return dailyCollectionList;
}


   Future<void> deleteDailyCollectionData(String farmerId, String docId) async {
    try {
      // Reference to the daily collection document to delete
      CollectionReference dailyCollection = _firestore
          .collection('farmer')
          .doc(farmerId)
          .collection('Daily Collection');

      // Delete the specified document using its ID
      await dailyCollection.doc(docId).delete();

      print('Daily Collection data deleted successfully');
    } catch (e) {
      print('Error deleting daily collection data: $e');
    }
  }
}
