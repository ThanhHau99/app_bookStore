import 'package:book_store_app/model/app_user.dart';
import 'package:book_store_app/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseUser {
  final String uid;

  DataBaseUser({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  // user data from snapshot
  AppUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return AppUser(
      uid: uid,
      name: data['Name'],
      phone: data['Phone'],
      email: data['Email'],
    );
  }

  // get user doc
  Stream<AppUser> get userData {
    if (uid != null) {
      return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    } else {
      return null;
    }
  }

  Future updateUserData(
      {String name, String phone, String email, List<Book> books}) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Phone': phone,
      'Email': email,
    });
  }

  // add book to fireStore
  Future<void> addBook(Book book) {
    Map<String, dynamic> data = {
      "Id": book.id,
      "Image": book.image,
      "Name": book.name,
      "Quantity": book.quantity,
      "Price": book.price,
    };

    return userCollection.doc(uid).collection("Books").doc(book.name).set(data);
  }

  List<Book> listBookFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((snapshot) {
      var data = snapshot.data() as Map<String, dynamic>;
      return Book.formJson(data);
    }).toList();
  }

  Stream<List<Book>> bookData() {
    return userCollection
        .doc(uid)
        .collection("Books")
        .snapshots()
        .map(listBookFromSnapshot);
  }

  // delete book
  Future<void> deleteBook(Book book) async {
    userCollection.doc(uid).collection("Books").doc(book.name).delete();
  }
}
