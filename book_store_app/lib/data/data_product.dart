import 'dart:async';

import 'package:book_store_app/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataProducts {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Books');

  List<Book> listProductFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((snapshot) {
      var data = snapshot.data() as Map<String, dynamic>;
      return Book.formJson(data);
    }).toList();
  }

  Stream<List<Book>> getData() {
    return collectionReference.snapshots().map(listProductFromSnapshot);
  }
}
