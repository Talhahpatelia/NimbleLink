import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link/models/user.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _user = User();
    final TextEditingController _pass = TextEditingController();
    final TextEditingController _confirmPass = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user;
    String status;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            autovalidate: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset: Offset(-7, 4), // changes position of shadow
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
                            hintText: 'First Name',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (firstName) {
                            _user.firstName = "$firstName";
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
                          offset: Offset(-7, 4), // changes position of shadow
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
                            hintText: 'Last Name',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (lastName) {
                            _user.lastName = "$lastName";
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
                          offset: Offset(-7, 4), // changes position of shadow
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
                          onChanged: (email) {
                            _user.email = "$email";
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
                          offset: Offset(-7, 4), // changes position of shadow
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
                          controller: _pass,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value.length < 6) {
                              return 'Password too short!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (password) {
                            _user.password = "$password";
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
                          offset: Offset(-7, 4), // changes position of shadow
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
                          controller: _confirmPass,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value != _pass.text) {
                              return 'Not Match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Re Password',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (rePassword) {
                            _user.rePassword = "$rePassword";
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
                          offset: Offset(-7, 4), // changes position of shadow
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
                            hintText: 'Address',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (address) {
                            _user.address = "$address";
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
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset: Offset(-7, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 350,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          hint: Text(
                            "Choose A Status",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              value: 'Health Profesional',
                              child: Center(
                                child: Text(
                                  'Health Profesional',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Comunity Worker',
                              child: Center(
                                child: Text(
                                  'Comunity Worker',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Hospital Worker',
                              child: Center(
                                child: Text(
                                  'Hospital Worker',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Doner',
                              child: Center(
                                child: Text(
                                  'Donner',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          onChanged: (String value) {
                            _user.status = value;
                            status = value;
                          },
                          value: status,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            child: RaisedButton(
                              onPressed: () async {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Going To Login Page',
                                        style: TextStyle(
                                          fontSize: 25,
                                        )),
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return MaterialApp(
                                        home: LoginPage(),
                                      );
                                    },
                                  ),
                                );
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                color: Colors.black,
                                padding: const EdgeInsets.all(10.0),
                                child: const Text(
                                  'Log In!',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              child: RaisedButton(
                                onPressed: () async {
                                  user =
                                      await FirebaseAuth.instance.currentUser();
                                  if (_formKey.currentState.validate()) {
                                    if (_user.status != '') {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white,
                                          content: Text(
                                            'Signing Up\nGO TO YOUR EMAIL AND VERIFY YOUR ACOUNT',
                                            style: TextStyle(
                                              color: Colors.grey[850],
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      );
                                      //ADD user
                                      Firestore.instance
                                          .collection("Users_Infomation")
                                          .document(user.uid)
                                          .setData({
                                        'Address': _user.address.trim(),
                                        'First Name': _user.firstName.trim(),
                                        'Last Name': _user.lastName.trim(),
                                        'Status': _user.status,
                                      });
                                      //Add Authenticated USER
                                      dynamic result =
                                          _auth.createUserWithEmailAndPassword(
                                              email: _user.email.trim(),
                                              password: _user.password.trim());
                                      if (result == null) {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Enter Valid Credentials\nCheck If You Not loged In Already',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) {
                                              return MaterialApp(
                                                home: LoginPage(),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    } else {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'No Status Selected\nChoose Status',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                textColor: Colors.white,
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  color: Colors.grey[850],
                                  padding: const EdgeInsets.all(10.0),
                                  child: const Text(
                                    'Register!',
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
