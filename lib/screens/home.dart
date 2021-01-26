import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'about.dart';
import 'projects/categories/agro_business.dart';
import 'projects/categories/industrial.dart';
import 'projects/categories/infrastructure.dart';
import 'projects/categories/per_category.dart';
import 'projects/projects.dart';
import 'wrapper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bienvenue',
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        autofocus: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[100],
                          focusColor: Colors.transparent,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          prefixIcon: Icon(
                            FontAwesomeIcons.search,
                            color: Colors.grey[400],
                          ),
                          hintText: 'Lancer une recherche',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 25.0,
                        horizontal: 14.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.blue[700],
                            Colors.blue[900],
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'SAIGE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Text(
                              "Société Africaine d'Investissement \net de Gestion de'Entreprises",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => Wrapper(),
                                    ),
                                  );
                                },
                                elevation: 10,
                                color: Colors.amber[700],
                                child: Text(
                                  'Démarrer',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
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
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 6.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildMenuItem(
                              imageLocation: "assets/cate.png",
                              label: "Catégories",
                              submit: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => PerCategory(),
                                  ),
                                );
                              },
                            ),
                            _buildMenuItem(
                              imageLocation: "assets/projet.png",
                              label: "Projets",
                              submit: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => Projects(),
                                  ),
                                );
                              },
                            ),
                            _buildMenuItem(
                                imageLocation: "assets/inves.png",
                                label: "Investisseurs",
                                submit: () {}),
                            _buildMenuItem(
                                imageLocation: "assets/a_propos.png",
                                label: "A propos",
                                submit: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => About(),
                                    ),
                                  );
                                }),
                            _buildMenuItem(
                              imageLocation: "assets/compte.png",
                              label: "Compte",
                              submit: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => Wrapper(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
                child: Container(
                  color: Colors.grey[100],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.purple[600],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: 25.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Text(
                            'Vous avez un projet ?',
                            style: TextStyle(
                              color: Colors.purple[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 30.0,
                            left: 15,
                            bottom: 30.0,
                            right: 15.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.indigo,
                                Colors.indigo[300],
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/idee.png",
                                  height: 60.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Explorer",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 5.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Idée",
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 175,
                                  child: AutoSizeText(
                                    "Soumettez à validation vos projets et obtenez des apppréciations et ou des apports en complément. L'avenir appartient aux hommes d'idées.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                    minFontSize: 6.0,
                                    maxLines: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 30.0,
                            left: 15,
                            bottom: 30.0,
                            right: 15.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.deepOrangeAccent[400],
                                Colors.orange[600],
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/plan.png",
                                  height: 60.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Explorer",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 5.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Plan",
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 175,
                                  child: AutoSizeText(
                                    "Notre équipe de managers vous aide dans l'élaboration et la mise en place de votre business plan. Envoyez les ici et recevez les touches de maître de nos experts.",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                    minFontSize: 6.0,
                                    maxLines: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 30.0,
                            left: 15,
                            bottom: 30.0,
                            right: 15.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.pink,
                                Colors.pink[300],
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/dol.png",
                                  height: 60.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Explorer",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 5.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Financement",
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 175,
                                  child: AutoSizeText(
                                    "Notre communauté est votre atout. Avec une « démographie digitale » de 1.000.000 de membres, veuillez à recevoir en temps réel et avec enthousiasme les réations.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                    minFontSize: 6.0,
                                    maxLines: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
                child: Container(
                  color: Colors.grey[100],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 8.0),
                      width: double.infinity,
                      child: Text(
                        'Nos catégories d\'actions ?',
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            _buildCard(
                              color: Colors.green,
                              text: 'Agribusiness',
                              imageLocation: "assets/agro.png",
                              submit: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => AgroBusiness(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            _buildCard(
                              imageLocation: "assets/in.png",
                              color: Colors.green,
                              text: 'Industriels',
                              submit: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => Industrial(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            _buildCard(
                              imageLocation: "assets/infra.png",
                              color: Colors.green,
                              text: 'Infrastructures',
                              submit: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => Infrastructure(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
                child: Container(
                  color: Colors.grey[100],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 8.0),
                      width: double.infinity,
                      child: Text(
                        'Tous nos domaines',
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildSector(
                            imageLocation: 'assets/images/agriculture.jpg',
                            text: 'Ferme',
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          _buildSector(
                            imageLocation: 'assets/images/road.jpg',
                            text: 'Routière',
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          _buildSector(
                            imageLocation: 'assets/images/industrial-plant.jpg',
                            text: 'Usine',
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          _buildSector(
                            imageLocation: 'assets/images/plane.jpg',
                            text: 'Aéroportuaire',
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          _buildSector(
                            imageLocation: 'assets/images/hospital.jpg',
                            text: 'Hôpital',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
                child: Container(
                  color: Colors.grey[100],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 8.0),
                      width: double.infinity,
                      child: Text(
                        'Tous nos domaines',
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      child: Text(
                        "En postant votre projet, nous nous chargerons \nde vérifier vos données pour approuver votre \n demande dans le cas où tout est corect. Ainsi \nles investisseurs pourront intervenir dans votre projet sans avoir à douter.",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildButton(
                              colors: <Color>[
                                Colors.purple[800],
                                Colors.purple[500]
                              ],
                              text: "1- DEMANDE",
                            ),
                            SizedBox(width: 8.0),
                            _buildButton(
                              colors: <Color>[
                                Colors.orange[800],
                                Colors.orange[500]
                              ],
                              text: "2- VERIFICATION",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildButton(
                              colors: <Color>[
                                Colors.pink[800],
                                Colors.pink[500]
                              ],
                              text: "3- APROBATION",
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            _buildButton(
                              colors: <Color>[
                                Colors.blue[800],
                                Colors.blue[500]
                              ],
                              text: "4- INVESTISSEMENT",
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    @required String imageLocation,
    @required String label,
    @required Function submit,
  }) {
    return InkWell(
      onTap: submit,
      child: Container(
        width: 60.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imageLocation,
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 8.0,
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
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
          width: 150.0,
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

  Widget _buildSector({
    String imageLocation,
    String text,
  }) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            imageLocation,
            height: 35.0,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 8.0,
              color: Colors.purple[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({List<Color> colors, String text}) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
