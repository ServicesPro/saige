import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(title: Text("à propos de nous".toUpperCase())),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  "assets/saige_logo.png",
                  height: 125.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Présentation de l'entreprise",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    AutoSizeText(
                      "Saige est une entreprise mondiale spécialisée en gestion de projet et d’entreprises offrant des services professionnels entièrement intégrés et un acteur de premier plan en matière de propriété d’infrastructures. À partir de bureaux situés dans l’espace CEDEAO, les membres du personnel de Saige sont fiers de bâtir l’Afrique de demain. Nos équipes et partenaires fournissent des solutions couvrant le cycle complet des projets, notamment dans les domaines de l’investissement de capital, des services-conseils, de la conception, de l’ingénierie, de la gestion de construction, des investissements de maintien et de l’exploitation et de l’entretien, pour les clients dans les secteurs Pétrole et gaz, Mines et métallurgie, Infrastructures, Énergie propre, Énergie fossiles et ICGP (Ingénierie, conception et gestion de projets). L’innovation, La vision et l’éthique associées à des technologies et des pratiques de pointe ont permis la réalisation de multiples réussites dans un éventail de projets; faisant de la Saige un incontournable centre d’affaire en Afrique.",
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      maxLines: 30,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Contacts: ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Agoènyvé reserve gendarmerie Agbalepedo, Lomé Togo",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('+228 900 545 53'),
                            FlatButton.icon(
                              onPressed: () async {
                                FlutterPhoneDirectCaller.callNumber(
                                  '+22890545553',
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.phone,
                                color: Colors.green,
                              ),
                              label: Text(
                                "Appeler",
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('+228 905 353 53'),
                            FlatButton.icon(
                              onPressed: () async {
                                await FlutterPhoneDirectCaller.callNumber(
                                  '+22890535353',
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.phone,
                                color: Colors.green,
                              ),
                              label: Text(
                                "Appeler",
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        RaisedButton.icon(
                          onPressed: () {
                            _launchEmail("info@saige-sas.com");
                          },
                          icon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          label: Text("info@saige-sas.com"),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
}
