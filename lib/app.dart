import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:link/models/user.dart';
import 'package:link/screens/wraper.dart';
import 'package:firebase_auth/firebase_auth.dart';
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user;
  @override
  Widget build(BuildContext context) {
    //either home or authenticate
    return StreamProvider<Login>.value(
      value: user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
