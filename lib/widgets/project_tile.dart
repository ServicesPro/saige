import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saige/models/project.dart';

import '../screens/projects/details.dart';

class ProjectTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ProjectTile({this.snapshot});

  @override
  Widget build(BuildContext context) {
    Project project = Project.fromMap(
      snapshot.data(),
      snapshot.data()['id'],
    );
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Details(project: project),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 30,
          shadowColor: Colors.black38,
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Column(
            children: [
              Hero(
                tag: project.id,
                child: project.image == ''
                    ? Image.asset(
                        "assets/default_project.png",
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Image.network(
                        project.image,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                // leading: CircleAvatar(
                //   radius: 25.0,
                //   backgroundColor: Colors.orange[100],
                // ),
                title: Text(project.name),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(project.country),
                    Text(project.totalAmount.toString() +
                        " " +
                        project.currency),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
