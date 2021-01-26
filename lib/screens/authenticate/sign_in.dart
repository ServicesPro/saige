import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saige/services/auth.dart';
import 'package:saige/widgets/auth_header.dart';
import 'package:saige/widgets/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool _loading = false;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: TextFormField(
                                  controller: _email,
                                  validator: (value) =>
                                      (value.isEmpty || !value.contains('@'))
                                          ? "Entrez un email valide"
                                          : null,
                                  style: style,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.black87),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
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
                                    labelStyle: TextStyle(color: Colors.black87),
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

                                        final result = await _authService
                                            .signInWithEmailAndPassword(
                                          email: _email.text,
                                          password: _password.text,
                                        );

                                        if (result == null) {
                                          setState(() {
                                            _loading = false;
                                          });

                                          showInSnackBar(
                                            value:
                                                "Quelque chose c'est mal passée",
                                          );
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
                                  widget.toggle();
                                },
                                child: Text(
                                  "Créer un compte maintenant",
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
