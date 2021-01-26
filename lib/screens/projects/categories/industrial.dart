import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:saige/services/auth.dart';

import '../../../widgets/project_tile.dart';

class Industrial extends StatefulWidget {
  @override
  _IndustrialState createState() => _IndustrialState();
}

class _IndustrialState extends State<Industrial> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.primaryColor,
        title: Text("Industriel"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.input_sharp),
            label: Text(""),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('projects')
            .where(
              'domain',
              arrayContainsAny: [
                'Parc industriel',
                'Ville',
                'Village intelligent',
                'Pipeline',
                'Dépôt pétrolier',
                'Usine clé en main',
              ],
            )
            .orderBy('name')
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/error.png',
                    height: 250,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Oops! Nous n'avons pas pas pu récupérer vos données.\nVeuillez réssayer plus tard. :D \n" +
                        snapshot.error.toString(),
                  ),
                ],
              ),
            );
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/connection.png',
                      height: 250,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Vous n'êtes pas connecter",
                    ),
                  ],
                ),
              );

            case ConnectionState.waiting:
              return Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              );

            case ConnectionState.active:
              List<DocumentSnapshot> projects = snapshot.data.docs;
              if (projects.length == 0) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/no_data.png',
                        height: 250,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Aucun projet n'a été enregistrer",
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: projects
                    .map(
                      (DocumentSnapshot document) => ProjectTile(
                        snapshot: document,
                      ),
                    )
                    .toList(),
              );

            case ConnectionState.done:
              return Center(
                child: SizedBox(),
              );
          }

          return Center(
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/error.png',
                    height: 250,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Aucun projet trouvé!"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
