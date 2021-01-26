import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saige/screens/projects/categories/state_projects.dart';
import 'package:saige/widgets/auth_header.dart';
import 'package:saige/widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';

import 'sign_in.dart';

class VerifyIdentity extends StatefulWidget {
  @override
  _VerifyIdentityState createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _pseudo;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _pseudo = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _pseudo.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return _loading
          ? Loading()
          : Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              key: _key,
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AuthHeader(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: TextFormField(
                                    controller: _pseudo,
                                    validator: (value) => value.isEmpty
                                        ? "Entrez un pseudo valide"
                                        : null,
                                    style: style,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: "Pseudo",
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: _password,
                                    validator: (value) => (value.length < 6)
                                        ? "Entrez un mot de passe long de 6+ caractères"
                                        : null,
                                    style: style,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: "Password",
                                      labelStyle:
                                          TextStyle(color: Colors.black87),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Theme.of(context).accentColor,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            _loading = true;
                                          });

                                          QuerySnapshot querySnapshot =
                                              await FirebaseFirestore.instance
                                                  .collection('vip')
                                                  .where(
                                                    'pseudo',
                                                    isEqualTo: _pseudo.text,
                                                  )
                                                  .where(
                                                    'password',
                                                    isEqualTo: _password.text,
                                                  )
                                                  .get();
                                          DocumentSnapshot document =
                                              querySnapshot.docs.first;

                                          if (document.exists) {
                                            setState(() {
                                              _loading = false;
                                            });
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => StateProjects(),
                                              ),
                                            );
                                          } else {
                                            setState(() {
                                              _loading = false;
                                            });
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Se connecter",
                                        style: style.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                FlatButton(
                                  onPressed: () {
                                    _launchEmail('info@saige-sas.com');
                                  },
                                  child: Text(
                                    "Contacter les administrateurspour avoir vos identifiants",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black87,
                                      fontSize: 16.0,
                                      fontFamily: "WorkSansSemiBold",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90.0,
                    ),
                    _buildFooterLogo()
                  ],
                ),
              ),
            );
    }
    return SignIn();
  }

  void _launchCaller(int number) async {
    var url = "tel:${number.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Impossible d'appeler ce numero";
    }
  }

  void _launchEmail(String emailID) async {
    var url = "mailto:$emailID?subject=Demande d'accès au partie projet d'état";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Impossible d'envoyer un mail à cet adresse";
    }
  }

  Widget _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/saige_logo.png',
          height: 40.0,
        ),
        Text(
          'SAIGE',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void showInSnackBar({BuildContext context, String value}) {
    FocusScope.of(context).requestFocus(
      FocusNode(),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold",
          ),
        ),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
