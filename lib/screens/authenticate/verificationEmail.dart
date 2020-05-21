import 'package:flutter/material.dart';

class VerificationEmail extends StatefulWidget {
  @override
  _VerificationEmailState createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Verification'),
        ),
      ),
    );
  }
}
