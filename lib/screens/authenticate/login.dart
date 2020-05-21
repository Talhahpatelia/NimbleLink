import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link/models/user.dart';
import 'package:link/models/users.dart';
import 'package:link/shared/loading.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _login = Login();
    final _formKey = GlobalKey<FormState>();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user;
    user.isEmailVerified;
    bool loading = false;

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[800],
              title: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.only(top: 30),
              child: Builder(
                builder: (context) => Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 10,
                                  blurRadius: 5,
                                  offset: Offset(
                                      -7, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: 350,
                                color: Colors.grey[800],
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  validator: validateEmail,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onChanged: (emailLog) {
                                    _login.emailLog =
                                        emailLog.trim().toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 10,
                                  blurRadius: 5,
                                  offset: Offset(
                                      -7, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: 350,
                                color: Colors.grey[800],
                                padding: EdgeInsets.all(10.0),
                                child: TextFormField(
                                  obscureText: true,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      )),
                                  onChanged: (passwordLog) {
                                    _login.passwordLog = "$passwordLog";
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              child: RaisedButton(
                                onPressed: () async {
                                  user = await FirebaseAuth.instance.currentUser();
                                  // Validate returns true if the form is valid, otherwise false.
                                  if (user.isEmailVerified == true) {
                                    if (_formKey.currentState.validate()) {
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _login.emailLog,
                                              password: _login.passwordLog);

                                      loading = true;
                                      dynamic result =
                                          await _auth.signInWithEmailAndPassword(
                                            email: _login.emailLog,
                                           password: _login.passwordLog);
                                      dynamic verified =
                                          await _auth.currentUser();
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                        });
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'The Email and Pasword Dont Match!\nError Signing in!',
                                              style: TextStyle(
                                                color: Colors.red[900],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          loading = true;
                                        });
                                        if (verified) {
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
                                        }
                                      }
                                    }
                                  } else if (user.isEmailVerified == false) {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.white,
                                        content: Text(
                                          'Email is not verified',
                                          style: TextStyle(
                                            color: Colors.red[900],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                elevation: 20,
                                textColor: Colors.white,
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  color: Colors.black,
                                  padding: const EdgeInsets.all(17.0),
                                  child: const Text(
                                    'Login!',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'MAKE SURE YOUR EMAIL IS VERIFIED\nBEFORE LOGING IN',
                            style: TextStyle(
                                color: Colors.grey[850],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

String validateEmail(String value) {
  RegExp regex = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
