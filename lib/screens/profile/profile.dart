import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saige/models/my_user.dart';
import 'package:saige/screens/projects/edition/create.dart';
import 'package:saige/screens/projects/dashboard.dart';
import 'package:saige/screens/projects/projects.dart';
import 'package:saige/services/auth.dart';

import 'edit_profile.dart';
import 'notifications.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text("Compte"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height / 5,
                          width: double.maxFinite,
                          child: CircleAvatar(
                            child: snapshot.data.data()['image'] == ''
                                ? Icon(
                                    Icons.person,
                                    size: 100,
                                  )
                                : Image.network(
                                    snapshot.data.data()['image'],
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                            radius: 100.0,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              // Provider.of<MyUser>(context).fullName ??
                              //     Provider.of<MyUser>(context).email,
                              snapshot.data.data()['fullName'] ??
                                  snapshot.data.data()['email'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => Notifications(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Votre profile",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditProfile(),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.white),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Modifier mon profile",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildButton(
                    label: "ajouter un projet".toUpperCase(),
                    submit: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CreateProject(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  _buildButton(
                    label: "investir dans un projet".toUpperCase(),
                    submit: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Projects(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  _buildButton(
                    label: "voir mes projets".toUpperCase(),
                    submit: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Dashboard(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  _buildSignOutButton(
                    label: "déconnection".toUpperCase(),
                    submit: () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton({@required String label, @required VoidCallback submit}) {
    return InkWell(
      onTap: submit,
      child: Container(
        height: 40.0,
        width: double.maxFinite,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: 6.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildSignOutButton({
    @required String label,
    @required VoidCallback submit,
  }) {
    return InkWell(
      onTap: submit,
      child: Container(
        alignment: Alignment.center,
        height: 40.0,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.red),
          color: Colors.red,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
