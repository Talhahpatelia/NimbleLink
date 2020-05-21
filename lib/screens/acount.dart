import 'package:flutter/material.dart';
import 'package:link/screens/infomation.dart';
import 'package:link/services/addProduct.dart';
import 'package:link/services/fadeTransition.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'main.dart';
import 'search.dart';
import 'settings.dart';
import 'package:provider/provider.dart';
import 'package:link/services/database.dart';
import 'package:link/models/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'order_list_Acount.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Acount extends StatefulWidget {
  @override
  _AcountState createState() => _AcountState();
}

class _AcountState extends State<Acount> {
  String nameOfAcount = '';
  String firstName;
  String lastName;
  Future getUserInfo() async {
    try {
      final FirebaseMessaging _fcm = FirebaseMessaging();
      _fcm.getToken().then((token) {
        print(token);
      });

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      String lastName, firstName;

      DocumentSnapshot snapshot = await Firestore.instance
          .collection("Users_Infomation")
          .document(user.uid)
          .get();
      firstName = snapshot.data['First Name'];
      lastName = snapshot.data['Last Name'];
      nameOfAcount = firstName + " " + lastName;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return StreamProvider<List<Orders>>.value(
              value: ProductEnter().orders,
              child: Scaffold(
                backgroundColor: Colors.grey[300],
                appBar: AppBar(
                  leading: Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 10,
                  title: Text(
                    nameOfAcount.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return MaterialApp(
                                  home: Settings(),
                                );
                              },
                            ),
                          );
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                body: Container(
                  // return OrderAcount
                ),
                bottomNavigationBar: CurvedNavigationBar(
                  index: 4,
                  backgroundColor: Colors.grey[300],
                  color: Colors.white,
                  items: <Widget>[
                    Icon(
                      Icons.home,
                      size: 40,
                    ),
                    Icon(
                      Icons.search,
                      size: 40,
                    ),
                    Icon(
                      Icons.add,
                      size: 50,
                    ),
                    Icon(
                      Icons.info,
                      size: 40,
                    ),
                    Icon(
                      Icons.account_circle,
                      size: 40,
                    ),
                  ],
                  animationDuration: Duration(
                    milliseconds: 300,
                  ),
                  animationCurve: Curves.fastOutSlowIn,
                  onTap: (index) {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: MainPage(),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: Search(),
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: AddProduct(),
                        ),
                      );
                    } else if (index == 3) {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: Info(),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      );
      reassemble();
    } catch (e) {
      print(e.toString());
    }
  }

  void main() async {
    if (nameOfAcount == '') {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      DocumentSnapshot snapshot = await Firestore.instance
          .collection("Users_Infomation")
          .document(user.uid)
          .get();
      firstName = snapshot.data['First Name'];
      lastName = snapshot.data['Last Name'];
      getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    main();
    const spinkit = SpinKitHourGlass(
      color: Colors.white,
      size: 50.0,
    );
    return spinkit;
  }
}
