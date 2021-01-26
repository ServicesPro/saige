import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:saige/models/my_user.dart';
import 'package:saige/widgets/loading.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _userId;
  // MyUser user;
  final _formKey = GlobalKey<FormState>();

  String _sex = "";

  String _lastName, _firstName, _age, _country;

  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _userId = (FirebaseAuth.instance.currentUser).uid;
    _lastName = "";
    _firstName = "";
    _age = "";
    _country = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String userId = _userId;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Modifier mon profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
          ),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = MyUser.fromMap(snapshot.data.data(), userId);
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _showModal(user: user);
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: user.image == ''
                              ? MediaQuery.of(context).size.height / 5
                              : MediaQuery.of(context).size.height * .5,
                          width: double.maxFinite,
                          child: CircleAvatar(
                            child: user.image == ''
                                ? Icon(
                                    Icons.person,
                                    size: 100,
                                  )
                                : Image.network(
                                    user.image,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                            radius: 100.0,
                          ),
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
                                initialValue: user.fullName == ''
                                    ? ''
                                    : user.fullName.split(' ')[1].toString(),
                                validator: (value) => value.isEmpty
                                    ? "Le nom ne peut être vide"
                                    : null,
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
                                  hintText: "Nom ...",
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
                              "Prénom(s)...",
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
                                initialValue: user.fullName == ''
                                    ? ''
                                    : user.fullName.split(' ')[0].toString(),
                                validator: (value) => value.isEmpty
                                    ? "Le prénom ne peut être vide"
                                    : null,
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
                                  hintText: "Prénom...",
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
                              "â".toUpperCase() + "ge...",
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
                                    ? "Entrer un âge valide"
                                    : null,
                                initialValue: user.age.toString(),
                                onChanged: (value) {
                                  setState(() {
                                    _age = value;
                                  });
                                },
                                style: TextStyle(
                                  color: Colors.grey[800],
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  hintText: "â".toUpperCase() + "ge...",
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
                          children: <Widget>[
                            Text(
                              "Sexe...",
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
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      hintText: "Choisir un sexe",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) => value.isEmpty
                                        ? "Veuillez choisir un sexe"
                                        : null,
                                    items: ['Féminin', 'Masculin']
                                        .map((value) => DropdownMenuItem(
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              value: value,
                                            ))
                                        .toList(),
                                    onChanged: (String value) {
                                      setState(() {
                                        _sex = value;
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
                                initialValue: user.country,
                                validator: (value) => value.isEmpty
                                    ? "Entrer un nom de  pays valide"
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
                                  hintText: "Pays...",
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              user.age = int.parse(_age);
                              user.fullName = _firstName + " " + _lastName;
                              user.country = _country;
                              user.sex = _sex;

                              // UserCrud.updateUser(data: user, id: user.uid);

                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .set(user.toJson());

                              _showInSnackBar(
                                "Enregistrement de l'utilisateur en cours...",
                              );

                              Navigator.of(context).pop();
                            }
                          },
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "é".toUpperCase() + "diter mon profile",
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
                );
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
    );
  }

  void _showInSnackBar(String value) {
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

  void _showModal({MyUser user}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Prendre une image de la caméra"),
                onTap: () async {
                  final pickedFile = await _imagePicker.getImage(
                    source: ImageSource.camera,
                  );
                  final file = File(pickedFile.path);
                  final String imageUrl = await _uploadImage(
                    file: file,
                    path: "Profile",
                  );
                  user.image = imageUrl;

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .set(user.toJson());
                  return Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                ),
                title: Text("Prendre une image de la galérie"),
                onTap: () async {
                  final pickedFile = await _imagePicker.getImage(
                    source: ImageSource.gallery,
                  );
                  final file = File(pickedFile.path);
                  final String imageUrl = await _uploadImage(
                    file: file,
                    path: "Profile",
                  );
                  user.image = imageUrl;

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .set(user.toJson());
                  return Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> _uploadImage({File file, String path}) async {
    final time = DateTime.now().toString();
    String ext = Path.basename(file.path).split('.')[1].toString();
    String image = time + "." + ext;
    final ref = FirebaseStorage.instance.ref().child(path + "/" + image);
    final task = ref.putFile(file);
    final snapshot = await task.onComplete;
    final String imageURL = (await snapshot.ref.getDownloadURL()).toString();

    return imageURL;
  }
}
