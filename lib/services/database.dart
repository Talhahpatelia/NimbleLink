import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link/models/orders.dart';

class DataBaseServerice {
  final String uid;
  DataBaseServerice({this.uid});
  //collection refrence
  final CollectionReference userDataCollection =
      Firestore.instance.collection('Users_Infomation');

  Future updateUserData(
      String firstName, String lastName, String address, String status) async {
    return await userDataCollection.document(uid).setData(
      {
        'First Name': firstName,
        'Last Name': lastName,
        'Address': address,
        'Status': status
      },
    );
  }

  Stream<QuerySnapshot> get userData {
    return userDataCollection.snapshots();
  }
}

class ProductEnter {
  final String uid;
  ProductEnter({this.uid});
  //collection refrence
  final CollectionReference productDataCollection =
      Firestore.instance.collection('Product_Information');
  final CollectionReference productPendingCollection =
      Firestore.instance.collection('Pending Products');

  Future updateProductData(
      String typeOfProduct,
      String dateNeededBy,
      String dateCurrently,
      int quantityOfProduct,
      int donationsRand,
      String productPosasion,
      String productId) async {
    return await productDataCollection.document(uid).setData(
      {
        'Type Of Product': typeOfProduct,
        'Date Needed By': dateNeededBy,
        'Current Date': dateCurrently,
        'Quantity': quantityOfProduct,
        'Donations': donationsRand,
        'Product To Be Posasion': productPosasion,
        'Product ID': productId
      },
    );
  }

  Future moveOrderToPending(
    String typeOfProduct,
    String dateNeededBy,
    String dateCurrently,
    int quantityOfProduct,
    int donationsRand,
    String productPosasion,
    String productId,
  ) async {
    return await productPendingCollection.document(uid).setData(
      {
        'Type Of Product': typeOfProduct,
        'Date Needed By': dateNeededBy,
        'Current Date': dateCurrently,
        'Quantity': quantityOfProduct,
        'Donations': donationsRand,
        'Product To Be Posasion': productPosasion,
        'Product ID': productId
      },
    );
  }

  // oders list from snapshot
  List<Orders> _ordersListSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Orders(
        typeOfProduct: doc.data['Type Of Product'] ?? '',
        dateNeededBy: doc.data['Date Needed By'] ?? '',
        dateCurrently: doc.data['Current Date'] ?? '',
        quantityOfProduct: doc.data['Quantity'] ?? 0,
        donationsRand: doc.data['Donations'] ?? 0,
        productPosasion: doc.data['Product To Be Posasion'] ?? '',
        productId: doc.data['Product ID'] ?? '',
      );
    }).toList();
  }

  //Order Streeam
  Stream<List<Orders>> get orders {
    return productDataCollection.snapshots().map(_ordersListSnapshot);
  }

  // move order to pending

}
