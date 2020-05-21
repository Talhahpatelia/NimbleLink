import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link/models/products.dart';
import 'package:link/screens/acount.dart';
import 'package:link/screens/infomation.dart';
import 'package:link/screens/main.dart';
import 'package:link/screens/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:link/services/fadeTransition.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _products = Products();
  String quantity;
  String _value;
  String _status;
  int _valueOfDonation;
  DateTime _date = DateTime.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: _date,
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _products.dateCurrently = DateTime.now().toString();
        _products.dateNeededBy = _date.toString().substring(0, 10).trim();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            autovalidate: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              spreadRadius: 10,
                              blurRadius: 5,
                              offset:
                                  Offset(-10, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: new Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.grey[800],
                            ),
                            child: Container(
                              width: 300,
                              height: 100,
                              color: Colors.grey[800],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  DropdownButton(
                                    items: [
                                      DropdownMenuItem<String>(
                                        child: Text(
                                          'Need',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontFamily: 'Schyler',
                                          ),
                                        ),
                                        value: 'Needs',
                                      ),
                                      DropdownMenuItem<String>(
                                        child: Text(
                                          'Have',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontFamily: 'Schyler',
                                          ),
                                        ),
                                        value: 'Has',
                                      )
                                    ],
                                    onChanged: (String status) {
                                      setState(() {
                                        _products.productPosasion = status;
                                        _status = status;
                                      });
                                    },
                                    hint: Text(
                                      'Status',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Schyler',
                                      ),
                                    ),
                                    value: _status,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset: Offset(-10, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: new Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.grey[800],
                          applyElevationOverlayColor: true,
                        ),
                        child: Container(
                          width: 300,
                          height: 100,
                          color: Colors.grey[800],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              DropdownButton<String>(
                                items: [
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      'N95 Mask/s',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Schyler',
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 'N95 Masks',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      'Glove/s',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Schyler',
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 'Gloves',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      'Hasmut Suite/s',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Schyler',
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 'Hasmut Suites',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      'Face Shield/s',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Schyler',
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 'Face Shields',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      'Goggle/s',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Schyler',
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 'Goggles',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      'Sanitizer/s',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 'Sanitizers',
                                  ),
                                ],
                                onChanged: (String value) {
                                  setState(() {
                                    _products.typeOfProduct = value;
                                    _value = value;
                                  });
                                },
                                hint: Text(
                                  ' Select Item',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Schyler',
                                  ),
                                ),
                                value: _value,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset: Offset(-10, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 300,
                        height: 100,
                        color: Colors.grey[800],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Quantity',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.white24,
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 4.0,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                thumbColor: Colors.white38,
                                overlayColor: Colors.white.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                                tickMarkShape: RoundSliderTickMarkShape(),
                                activeTickMarkColor: Colors.white60,
                                inactiveTickMarkColor: Colors.white10,
                                valueIndicatorShape:
                                    PaddleSliderValueIndicatorShape(),
                                valueIndicatorColor: Colors.white,
                                valueIndicatorTextStyle: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                              child: Slider(
                                min: 0,
                                max: 100,
                                value: _products.quantityOfProduct.toDouble(),
                                onChanged: (value) {
                                  setState(() {
                                    _products.quantityOfProduct = value.toInt();
                                    quantity = value.toString();
                                  });
                                },
                                divisions: 100,
                                label: _products.quantityOfProduct
                                    .round()
                                    .toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset: Offset(-10, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 300,
                        height: 100,
                        color: Colors.grey[800],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Delivery',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                      ),
                                      iconSize: 50,
                                      onPressed: () {
                                        selectDate(context);
                                      },
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset: Offset(-10, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.grey[800],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: 300,
                          height: 100,
                          color: Colors.grey[800],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              DropdownButton<int>(
                                items: [
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'R10',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 10,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'R50',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 50,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'R100',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 100,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'R250',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 250,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'R500',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 500,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'R750',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 750,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _products.donationsRand = value;
                                    _valueOfDonation = value;
                                  });
                                },
                                hint: Text(
                                  'Donations (optional)',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                value: _valueOfDonation,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(260, 20, 0, 40),
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        if (_products.donationsRand == 1) {
                          _products.donationsRand = 0;
                        }
                        if (_products.productPosasion != '') {
                          if (_products.typeOfProduct != '') {
                            if (_products.quantityOfProduct != 0) {
                              if (_products.dateNeededBy != '') {
                                dynamic result = Firestore.instance
                                    .collection("Product_Information")
                                    .document(_products.productId)
                                    .setData({
                                  'Current Date': _products.dateCurrently,
                                  'Date Needed By': _products.dateNeededBy,
                                  'Donations': _products.donationsRand,
                                  'Product ID': _products.productId,
                                  'Product To Be Posasion':
                                      _products.productPosasion,
                                  'Quantity': _products.quantityOfProduct,
                                  'Type Of Product': _products.typeOfProduct
                                });

                                if (result != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) {
                                        return MaterialApp(
                                          home: MainPage(),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      elevation: 10,
                                      content: Text(
                                        'Infomation Enterd Not Valid\n',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 27,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                setState(() {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Choose Date For Delivery\nClick On The Calender\n',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 27,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              }
                            } else {
                              setState(() {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please Choose A Quantity\n',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 27,
                                      ),
                                    ),
                                  ),
                                );
                              });
                            }
                          } else {
                            setState(() {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please Choose A Product Type\n',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 27,
                                    ),
                                  ),
                                ),
                              );
                            });
                          }
                        } else {
                          setState(() {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Plese Slect One Of The Options In Status',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 27,
                                  ),
                                ),
                              ),
                            );
                          });
                        }
                      },
                      child: const Icon(
                        Icons.check,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
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
          } else if (index == 3) {
            Navigator.push(
              context,
              FadeRoute(
                page: Info(),
              ),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              FadeRoute(
                page: Acount(),
              ),
            );
          }
        },
      ),
    );
  }
}
