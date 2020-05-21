import 'package:flutter/material.dart';
import 'package:link/models/orders.dart';
import 'package:link/models/users.dart';
import 'package:link/screens/main.dart';
import 'package:link/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersTile extends StatefulWidget {
  final Orders orders;
  final UserData userData;

  OrdersTile({this.orders, this.userData});

  @override
  _OrdersTileState createState() => _OrdersTileState();
}

class _OrdersTileState extends State<OrdersTile> {
  IconData iconType;

  Color colorOfCard;

  Color colorOfInputField;

  Color colorOfIcon;

  FirebaseUser user;

  var id;

  String firstName;

  String lastName;

  String status;

  String productPosasion;

  String currentDate;

  String productIdUId;

  String textFormHintText;

  String statusOfProduct;

  int quantityOfProductsReamining = 0;

  int quantityOfProductsTaken = 0;

  int elevationFloatingButton;

  bool textFormEnabled = true;

  int productAmountv;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.orders.productPosasion == 'Has') {
      iconType = Icons.battery_charging_full;
      colorOfCard = Colors.greenAccent[700];
      productPosasion = 'Amount Needed';
      statusOfProduct = 'Available';
      colorOfInputField = colorOfCard;
      elevationFloatingButton = 10;
      colorOfIcon = Colors.green;
    } else if (widget.orders.productPosasion == 'Needs') {
      iconType = Icons.battery_alert;
      colorOfCard = Colors.redAccent[400];
      productPosasion = 'Amount I Can Supply';
      statusOfProduct = 'in NEED!';
      colorOfInputField = colorOfCard;
      elevationFloatingButton = 10;
      colorOfIcon = Colors.green;
    } else if (widget.orders.productPosasion == 'Pending') {
      iconType = Icons.battery_unknown;
      colorOfCard = Colors.orangeAccent[400];
      statusOfProduct = 'In Pending';
      textFormEnabled = false;
      colorOfInputField = Colors.white;
      elevationFloatingButton = 0;
      colorOfIcon = Colors.white;
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 10,
        color: colorOfCard,
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: Icon(
            iconType,
            size: 40,
          ),
          title: Text(
            '${widget.orders.typeOfProduct}  Amount: ${widget.orders.quantityOfProduct}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: Text('Delivery: ${widget.orders.dateNeededBy}'),
          onTap: () async {
            id = widget.orders.productId.split(" ")[0];
            productIdUId = id.toString();
            DocumentSnapshot snapshot = await Firestore.instance
                .collection("Users_Infomation")
                .document(id)
                .get();
            firstName = snapshot.data['First Name'];
            lastName = snapshot.data['Last Name'];
            status = snapshot.data['Status'];
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return StreamProvider.value(
                    value: DataBaseServerice().userData,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text(
                          '${widget.orders.quantityOfProduct}  ${widget.orders.typeOfProduct.toString()} $statusOfProduct',
                        ),
                        backgroundColor: colorOfCard,
                      ),
                      body: Container(
                        child: Builder(
                          builder: (context) => Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Colors.grey[800],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        width: double.infinity,
                                        color: colorOfInputField,
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            TextFormField(
                                              enabled: textFormEnabled,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: productPosasion,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (productAmount) {
                                                productAmountv =
                                                    int.parse(productAmount);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      300, 40, 10, 40),
                                  child: FloatingActionButton(
                                    elevation:
                                        elevationFloatingButton.toDouble(),
                                    backgroundColor: Colors.white,
                                    onPressed: () async {
                                      if (productAmountv != null &&
                                          productAmountv != 0) { 
                                        if (productAmountv ==
                                            widget.orders.quantityOfProduct) {
                                          //== Amount in cart
                                          currentDate =
                                              DateTime.now().toString();
                                          user = await FirebaseAuth.instance
                                              .currentUser();
                                          //
                                          quantityOfProductsReamining = 0;
                                          // Update data and make it pending
                                          Firestore.instance
                                              .collection('Product_Information')
                                              .document(
                                                  widget.orders.productId +
                                                      " " +
                                                      user.uid.toString() +
                                                      " " +
                                                      currentDate)
                                              .setData({
                                            'Type Of Product':
                                                widget.orders.typeOfProduct,
                                            'Date Needed By':
                                                widget.orders.dateNeededBy,
                                            'Current Date':
                                                widget.orders.dateCurrently,
                                            'Quantity':
                                                widget.orders.quantityOfProduct,
                                            'Donations':
                                                widget.orders.donationsRand,
                                            'Product To Be Posasion': 'Pending',
                                            'Product ID':
                                                widget.orders.productId +
                                                    " " +
                                                    user.uid.toString() +
                                                    " " +
                                                    currentDate,
                                          });
                                          //Delete Document
                                          Firestore.instance
                                              .collection('Product_Information')
                                              .document(widget.orders.productId)
                                              .delete();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(builder:
                                                (BuildContext context) {
                                              return MainPage();
                                            }),
                                          );
                                          //Make notification_living
                                          Firestore.instance
                                              .collection('Information')
                                              .document(id)
                                              .collection('Information_Living')
                                              .document(widget.orders.productId +
                                                      " " +
                                                      user.uid.toString() +
                                                      " " +
                                                      currentDate)
                                              .setData({
                                                'Quantity Taken': widget.orders.quantityOfProduct,
                                                'UserName' : '$firstName $lastName'
                                              });
                                        } else if (productAmountv <
                                            widget.orders.quantityOfProduct) {
                                          user = await FirebaseAuth.instance
                                              .currentUser();
                                          currentDate =
                                              DateTime.now().toString();
                                          //Add to pending products
                                          Firestore.instance
                                              .collection('Pending_Products')
                                              .document(
                                                  widget.orders.productId +
                                                      " " +
                                                      user.uid.toString() +
                                                      " " +
                                                      currentDate)
                                              .setData({
                                            'Type Of Product':
                                                widget.orders.typeOfProduct,
                                            'Date Needed By':
                                                widget.orders.dateNeededBy,
                                            'Current Date':
                                                widget.orders.dateCurrently,
                                            'Quantity':
                                                widget.orders.quantityOfProduct,
                                            'Donations':
                                                widget.orders.donationsRand,
                                            'Product To Be Posasion':
                                                widget.orders.productPosasion,
                                            'Product ID':
                                                widget.orders.productId +
                                                    " " +
                                                    user.uid.toString() +
                                                    " " +
                                                    currentDate,
                                          });
                                          //remaining quantity
                                          quantityOfProductsReamining =
                                              widget.orders.quantityOfProduct -
                                                  productAmountv;
                                          //Add the pending product
                                          Firestore.instance
                                              .collection('Product_Information')
                                              .document(
                                                  widget.orders.productId +
                                                      " " +
                                                      user.uid.toString() +
                                                      " " +
                                                      currentDate)
                                              .setData({
                                            'Type Of Product':
                                                widget.orders.typeOfProduct,
                                            'Date Needed By':
                                                widget.orders.dateNeededBy,
                                            'Current Date':
                                                widget.orders.dateCurrently,
                                            'Quantity': productAmountv,
                                            'Donations':
                                                widget.orders.donationsRand,
                                            'Product To Be Posasion': 'Pending',
                                            'Product ID':
                                                widget.orders.productId +
                                                    " " +
                                                    user.uid.toString() +
                                                    " " +
                                                    currentDate
                                          });
                                          //Add remaining product
                                          Firestore.instance
                                              .collection('Product_Information')
                                              .document(productIdUId +
                                                  ' ' +
                                                  currentDate)
                                              .setData({
                                            'Type Of Product':
                                                widget.orders.typeOfProduct,
                                            'Date Needed By':
                                                widget.orders.dateNeededBy,
                                            'Current Date':
                                                widget.orders.dateCurrently,
                                            'Quantity':
                                                quantityOfProductsReamining,
                                            'Donations':
                                                widget.orders.donationsRand,
                                            'Product To Be Posasion':
                                                widget.orders.productPosasion,
                                            'Product ID':
                                                productIdUId + ' ' + currentDate
                                          });
                                          //Delete The father But we moved it to bending products
                                          //at the top
                                          Firestore.instance
                                              .collection('Product_Information')
                                              .document(widget.orders.productId)
                                              .delete();
                                          //Nacigate back
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(builder:
                                                (BuildContext context) {
                                              return MainPage();
                                            }),
                                          );
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.white,
                                              content: Text(
                                                'Choose a quantity based on stock avilable',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.red[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.white,
                                            content: Text(
                                              'Enter A Number!',
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.red[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.check,
                                      size: 40,
                                      color: colorOfIcon,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
