import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saige/models/project.dart';
import 'package:uuid/uuid.dart';

import '../dashboard.dart';

class CreateProject extends StatefulWidget {
  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  List<String> _africanCountries, _domains, _currencies;

  String _projectName,
      _countryName,
      _description,
      _duration,
      _currency,
      _totalAmount,
      _domain,
      _userId;

  @override
  void initState() {
    super.initState();

    _africanCountries = [
      "Afrique du sud",
      "Algérie",
      "Angola",
      "Bénin",
      "Botswana",
      "Burkina-Faso",
      "Burundi",
      "Cameroun",
      "Cap-Vert",
      "République centrafricaine",
      "Comores",
      "République du congo",
      "République démocratique du congo",
      "Côte d'ivioire",
      "Djibouti",
      "é".toUpperCase() + "gypte",
      "é".toUpperCase() + "rythrée",
      "Eswatini",
      "é".toUpperCase() + "thiopie",
      "Gabon",
      "Gambie",
      "Ghana",
      "Guinée",
      "Guinée-Bissau",
      "Guinée équatoriale",
      "Kenya",
      "Lesotho",
      "Libéria",
      "Libye",
      "Madagascar",
      "Malawi",
      "Mali",
      "Maroc",
      "Maurice",
      "Mauritanie",
      "Mozanbique",
      "Namibie",
      "Niger",
      "Nigeria",
      "Ouganda",
      "Rwanda",
      "São Tomé-et-Principe",
      "Sénégal",
      "Seychelles",
      "Sierra Leone",
      "Somalie",
      "Soudan",
      "Soudan du sud",
      "Tanzanie",
      "Tchad",
      "Togo",
      "Tunisie",
      "Zambie",
      "Zimbabwe",
    ];

    _domains = [
      "INFRASTRUCTURE",
      "Routière",
      "Pont",
      "Aéroporturaie",
      "Hotelerie",
      "Logements sociaux",
      "Hôpitaux",
      "INDUSTRIELS",
      "Parc industriel",
      "Ville",
      "Village intelligent",
      "Pipeline",
      "Dépôt pétrolier",
      "Usine clé en main",
      "AGRI-BUSINESS",
      "Agropole",
      "Ferme intégrée",
    ];
    _currencies = ["USD", "EUR", "XOF", "XAF"];
    _projectName = "";
    _countryName = "";
    _description = "";
    _duration = "";
    _domain = "";
    _currency = "";
    _totalAmount = "";

    _getUserId();
  }

  void _getUserId() {
    setState(() {
      _userId = (FirebaseAuth.instance.currentUser).uid;
    });
  }

  @override
  void dispose() {
    _projectName = "";
    _countryName = "";
    _description = "";
    _duration = "";
    _domain = "";
    _currency = "";
    _totalAmount = "";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Création d'un nouveau\nprojet"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey[100],
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
                          "Nom du projet" + "...",
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "(" +
                              "Donner un nom qui fait valoir votre projet." +
                              ")",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
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
                            validator: (value) => (value.isEmpty)
                                ? "Le nom du projet ne peut-être vide."
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _projectName = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Nom du projet" + "...",
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
                    height: 20.0,
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
                      children: <Widget>[
                        Text(
                          "Sélectionner le pays" + "...",
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "(" +
                              "Choisir le pays dans lequel s'exécutera le projet" +
                              ")",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DropdownButtonFormField(
                                validator: (value) => (value.isEmpty)
                                    ? "Vous devez choisir un pays."
                                    : null,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  hintText: "Sélectionner le pays...",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  border: InputBorder.none,
                                ),
                                items: _africanCountries
                                    .map(
                                      (value) => DropdownMenuItem(
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        value: value,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    _countryName = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey[100],
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
                          "Description du projet" + "...",
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "(" +
                              "Donner un nom qui fait valoir votre projet." +
                              ")",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
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
                            validator: (value) => (value.isEmpty)
                                ? "La description du projet ne peut-être vide."
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _description = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 15,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Description du projet" + "...",
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
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey[100],
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
                          "Durée (en jours)" + "...",
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "(" +
                              "Donner la différence entre aujourd'hui et la\ndata d'échéance du projet" +
                              ")",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
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
                            validator: (value) => (value.isEmpty)
                                ? "La durée du projet ne peut-être vide."
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _duration = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Durée (en jours)" + "...",
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
                    height: 20.0,
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
                      children: <Widget>[
                        Text(
                          "Sélectionner le domaine..." + "...",
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "(" +
                              "Mettre le domaine dans le lequel s'inscrit le projet\nque vous nous soumettez." +
                              ")",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DropdownButtonFormField(
                                validator: (value) => (value.isEmpty)
                                    ? "Le domaine du projet ne peut-être vide."
                                    : null,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  hintText: "Sélectionner le domaine...",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  border: InputBorder.none,
                                ),
                                items: _domains
                                    .map((value) => DropdownMenuItem(
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          value: value,
                                        ))
                                    .toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    _domain = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // todo
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
                      children: <Widget>[
                        Text(
                          "Sélectionner la monnaie..." + "...",
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "(" +
                              "Chosir dans quelle devise de monnaie vous avez\nexprimer le bilan total de votre projet" +
                              ")",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DropdownButtonFormField(
                                validator: (value) => (value.isEmpty)
                                    ? "La monnaie du projet ne peut-être vide."
                                    : null,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  hintText: "Sélectionner la monnaie...",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  border: InputBorder.none,
                                ),
                                items: _currencies
                                    .map((value) => DropdownMenuItem(
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          value: value,
                                        ))
                                    .toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    _currency = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey[100],
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
                          "Montant total",
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "(" +
                              "A combien s'élève votre projet dans la devise de \nmonétaire choisie" +
                              ")",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
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
                            validator: (value) => (value.isEmpty)
                                ? "Le coût du projet ne peut-être vide."
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _totalAmount = value;
                              });
                            },
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Montant total" + "...",
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
                    height: 30.0,
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
                          Project project = Project(
                            id: Uuid().v1().toString(),
                            userId: _userId,
                            name: _projectName,
                            country: _countryName,
                            description: _description,
                            duration: _duration,
                            currency: _currency,
                            totalAmount: _totalAmount,
                            domain: _domain,
                            isPublic: true,
                          );
                          // print(_userId);

                          // ProjectCrud.addProject(data: project);
                          FirebaseFirestore.instance
                              .collection('projects')
                              .doc(project.id)
                              .set(project.toJson());

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Dashboard(),
                            ),
                          );
                        }
                      },
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Créer mon projet",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
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
