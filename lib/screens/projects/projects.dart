import 'package:flutter/material.dart';
import 'package:saige/screens/authenticate/verify_identity.dart';

import 'categories/public.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Projets"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildCard(
                color: Colors.green,
                imageLocation: "assets/projects/public.png",
                submit: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Public(),
                    ),
                  );
                },
                text: "Projets public",
              ),
              _buildCard(
                color: Colors.red,
                imageLocation: "assets/projects/etat.png",
                submit: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      // builder: (_) => StateProjects(),
                      builder: (_) => VerifyIdentity(),
                    ),
                  );
                },
                text: "Projets d'" + "é".toUpperCase() + "tats",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    @required String imageLocation,
    @required Color color,
    @required String text,
    @required Function submit,
  }) {
    return InkWell(
      onTap: submit,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 30,
        shadowColor: Colors.black38,
        child: Container(
          width: 250.0,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(25.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          imageLocation,
                          height: 50,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                            color: Colors.purple[900],
                            fontWeight: FontWeight.w600,
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
    );
  }
}
