import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saige/models/investor.dart';
import 'package:saige/services/payment_service.dart';

class PayForm extends StatefulWidget {
  final String projectId;
  final String currency;

  PayForm({this.projectId, this.currency});

  @override
  _PayFormState createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _lastName, _firstName, _email, _phone, _country, _amount;

  @override
  void initState() {
    super.initState();

    _lastName = "";
    _firstName = "";
    _email = "";
    _phone = "";
    _country = "";
    _amount = "";

    StripeService.init();
  }

  @override
  void dispose() {
    _lastName = "";
    _firstName = "";
    _email = "";
    _phone = "";
    _country = "";
    _amount = "";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payement"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset.zero,
                        blurRadius: 3.0,
                        spreadRadius: 1.5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nom...",
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Entrer un nom valide" : null,
                          onChanged: (value) {
                            setState(() {
                              _lastName = value;
                            });
                          },
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            hintText: "Votre nom...",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset.zero,
                        blurRadius: 3.0,
                        spreadRadius: 1.5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Prénom...",
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Entrer un prénom valide" : null,
                          onChanged: (value) {
                            setState(() {
                              _firstName = value;
                            });
                          },
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            hintText: "Votre prénom",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset.zero,
                        blurRadius: 3.0,
                        spreadRadius: 1.5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email...",
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          validator: (value) =>
                              value.isEmpty || !value.contains("@")
                                  ? "Entrer un email valide"
                                  : null,
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            hintText: "Adresse email...",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset.zero,
                        blurRadius: 3.0,
                        spreadRadius: 1.5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Téléphone...",
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          validator: (value) => value.isEmpty
                              ? "Entrer un téléphone valide"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _phone = value;
                            });
                          },
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            hintText: "Votre numéro de télphone...",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset.zero,
                        blurRadius: 3.0,
                        spreadRadius: 1.5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pays...",
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          validator: (value) => value.isEmpty
                              ? "Entrer un nom de pays valide"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _country = value;
                            });
                          },
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            hintText: "Dans quel pays habitez-vous...",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset.zero,
                        blurRadius: 3.0,
                        spreadRadius: 1.5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Montant...",
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Entrer un montant valide" : null,
                          onChanged: (value) {
                            setState(() {
                              _amount = value;
                            });
                          },
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            hintText: "Quel montant voulez-vous investir...",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50.0,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Investor investor = Investor(
                          fullName: _firstName + " " + _lastName.toUpperCase(),
                          email: _email,
                          phone: _phone,
                          country: _country,
                          amount: _amount,
                        );

                        final response = await _onItemPress(context);

                        if (response) {
                          FirebaseFirestore.instance
                              .collection('projects')
                              .doc(widget.projectId)
                              .collection('investors')
                              .add(investor.toJson());

                          showInSnackBar(
                            "Enregistrement de l'investissement en cours...",
                          );

                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) =>
                          //         CardsHome(amount: investor.amount),
                          //   ),
                          // );
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Investir dans se projet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onItemPress(BuildContext context) async {
    var response = await StripeService.payWithNewcard(
      amount: _amount,
      currency: widget.currency,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message),
        duration: Duration(
          milliseconds: response.success == true ? 1200 : 3000,
        ),
      ),
    );
    return response.success;
  }

  void showInSnackBar(String value) {
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
