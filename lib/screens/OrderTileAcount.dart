import 'package:flutter/material.dart';
import 'package:link/models/orders.dart';
import 'package:link/models/user.dart';
import 'package:link/models/users.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersTileAcount extends StatefulWidget {
  final Orders orders;
  final UserData userData;
  OrdersTileAcount({this.orders, this.userData});

  @override
  _OrdersTileAcountState createState() => _OrdersTileAcountState();
}

class _OrdersTileAcountState extends State<OrdersTileAcount> {
  IconData iconType;

  Color colorOfCard;

  Color colorOfInputField;

  Color colorOfIcon;

  String id;

  String firstName;

  String lastName;

  String status;

  String productPosasion;

  String currentDate;

  String textFormHintText;

  String statusOfProduct;

  int elevationFloatingButton;

  bool textFormEnabled = true;

  var userSame;

  var userIdProducts;

  Future<dynamic> userDataId() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      if (user.uid == (widget.orders.productId.toString().split(" ")[0])) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Login>(context);
    userIdProducts = widget.orders.productId.toString();
    userIdProducts = userIdProducts.split(" ");
    if (user.uid == userIdProducts[0]) {
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
            onLongPress: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Delete This Product 👇",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Info",
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Information Of Product",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                actions: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        'Type: ${widget.orders.typeOfProduct}',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Quantity: ${widget.orders.quantityOfProduct}',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Date Created: ${widget.orders.dateCurrently.split(" ")[0]}',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Delevery Date: ${widget.orders.dateNeededBy}',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Donation: R${widget.orders.donationsRand}',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Product is $statusOfProduct',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: colorOfCard,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                      FlatButton(
                          child: Text(
                            "Close",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      FlatButton(
                        child: Text(
                          "Accept",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Firestore.instance
                              .collection('Product_Information')
                              .document(widget.orders.productId)
                              .delete();
                        },
                      ),
                    ],
                  );
                },
              );
            },
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
            onTap: () async {},
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
      );
    }
  }
}
