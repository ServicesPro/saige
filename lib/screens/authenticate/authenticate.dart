import 'package:flutter/material.dart';

import 'register.dart';
import 'sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignIn = true;

  @override
  Widget build(BuildContext context) {
    if (_showSignIn) {
      return SignIn(toggle: _toggleView);
    } else {
      return Register(toggle: _toggleView);
    }
  }

  void _toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }
}
