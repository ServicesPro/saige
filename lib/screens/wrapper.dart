import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saige/models/my_user.dart';

import 'authenticate/authenticate.dart';
import 'profile/profile.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    // return either Authenticate or Home widget
    if (user == null) {
      return Authenticate();
    } else {
      return Profile();
    }
  }
}
