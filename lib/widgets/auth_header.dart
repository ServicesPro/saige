import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(90.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: Image.asset("assets/saige_logo.png"),
        ),
      ),
    );
  }
}
