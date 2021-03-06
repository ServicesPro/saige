import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:saige/widgets/project_tile.dart';
import 'package:saige/services/auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();
  String _userId;

  @override
  void initState() {
    super.initState();

    _userId = (FirebaseAuth.instance.currentUser).uid;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: theme.primaryColor,
        title: Text("Tableau de bord"),
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
            .where('userId', isEqualTo: _userId)
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
