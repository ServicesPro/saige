import 'package:flutter/material.dart';

import 'agro_business.dart';
import 'industrial.dart';
import 'infrastructure.dart';

class PerCategory extends StatefulWidget {
  @override
  _PerCategoryState createState() => _PerCategoryState();
}

class _PerCategoryState extends State<PerCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Catégories"),
      ),
      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
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
}
