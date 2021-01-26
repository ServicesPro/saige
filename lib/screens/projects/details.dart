import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saige/models/project.dart';
import 'package:saige/screens/credit_cards/pay_form.dart';
import 'package:saige/screens/projects/edition/edit_project.dart';
import 'package:saige/widgets/percentage.dart';

class Details extends StatefulWidget {
  final Project project;

  Details({@required this.project});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _userId;

  @override
  void initState() {
    super.initState();

    _userId = (FirebaseAuth.instance.currentUser)?.uid;
  }

  @override
  Widget build(BuildContext context) {
    // final String userId = Provider.of<AuthService>(context).userId;
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails'),
        actions: <Widget>[
          widget.project.userId == _userId
              ? IconButton(
                  iconSize: 35,
                  icon: Icon(Icons.delete_forever),
                  onPressed: () async {
                    // await ProjectCrud.removeProject(id: );
                    FirebaseFirestore.instance
                        .collection('projects')
                        .doc(widget.project.id)
                        .delete();
                    Navigator.pop(context);
                  },
                )
              : Text(''),
          widget.project.userId == _userId
              ? IconButton(
                  iconSize: 35,
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            EditProject(projectId: widget.project.id),
                      ),
                    );
                  },
                )
              : Text(''),
          // IconButton(
          //   iconSize: 35,
          //   icon: Icon(Icons.credit_card),
          //   tooltip: "Investir",
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (_) => PayForm(
          //           projectId: widget.project.id,
          //           currency: widget.project.currency,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PayForm(
                    projectId: widget.project.id,
                    currency: widget.project.currency,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.credit_card,
              size: 35.0,
            ),
            label: Text(
              "Investir",
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('projects')
            .doc(widget.project.id)
            .snapshots(),
        // .collection('investors')
        // .snapshots(),
        builder: (context, snapshot) {
          Project project = Project.fromMap(snapshot.data.data(), widget.project.id);
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Hero(
                      tag: project.id,
                      child: project.image == ''
                          ? Image.asset(
                              "assets/default_project.png",
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width,
                            )
                          : Image.network(
                              project.image,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Nom",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        project.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Montant",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        "${project.totalAmount} ${project.currency}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Durée",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        '${project.duration} jours',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Pays",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        project.country,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AutoSizeText(
                    widget.project.description,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 3.0,
                    ),
                    maxLines: 100,
                  ),
                  SizedBox(height: 20.0),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('projects')
                          .doc(widget.project.id)
                          .collection('investors')
                          .snapshots(),
                      builder: (context, snapshot) {
                        List<DocumentSnapshot> docs = snapshot.data.docs;
                        List<double> amounts = docs
                            .map(
                              (DocumentSnapshot document) => double.parse(
                                document.data()['amount'],
                              ),
                            )
                            .toList();
                        double amountSum = amounts.fold(0,
                            (previousValue, amount) => previousValue + amount);
                        double percentage = amountSum /
                            double.parse(widget.project.totalAmount);
                        return Percentage(
                          endValue: percentage,
                        );
                      }),
                  SizedBox(height: 12.0),
                  Text(
                    "Niveau d'investissement de se projet",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
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
        },
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
}
