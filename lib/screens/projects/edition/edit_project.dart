import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:saige/models/project.dart';
import 'package:saige/screens/projects/edition/project_form.dart';
import 'package:saige/widgets/loading.dart';

class EditProject extends StatefulWidget {
  final String projectId;

  EditProject({this.projectId});

  @override
  _EditProjectState createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edition"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('projects')
            .doc(widget.projectId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final project = Project.fromMap(
              snapshot.data.data(),
              widget.projectId,
            );
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _showModal(project: project);
                          },
                          child: Column(
                            children: <Widget>[
                              AutoSizeText(
                                "Chosir une image pour mettre en avant le projet",
                                maxLines: 5,
                              ),
                              SizedBox(height: 20),
                              Container(
                                color: Colors.transparent,
                                height: MediaQuery.of(context).size.height * .5,
                                width: double.maxFinite,
                                child: Container(
                                  child: project.image == ''
                                      ? Icon(
                                          Icons.camera,
                                          size: 75.0,
                                        )
                                      : Image.network(
                                          project.image,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .5,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        Center(
                          child: RaisedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ProjectForm(
                                    projectId: widget.projectId,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                            label: Text("Modifier d'autres infos"),
                            color: Theme.of(context).accentColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Loading();
        },
      ),
    );
  }

  void _showModal({Project project}) {
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
                  final pickedFile =
                      await _imagePicker.getImage(source: ImageSource.camera);
                  final file = File(pickedFile.path);
                  final String imageUrl =
                      await _uploadImage(file: file, path: "Projects");
                  print(imageUrl);
                  project.image = imageUrl;

                  FirebaseFirestore.instance
                      .collection('projects')
                      .doc(project.id)
                      .set(project.toJson());
                  return Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                ),
                title: Text("Prendre une image de la galérie"),
                onTap: () async {
                  final pickedFile =
                      await _imagePicker.getImage(source: ImageSource.gallery);
                  final file = File(pickedFile.path);
                  final String imageUrl =
                      await _uploadImage(file: file, path: "Projects");
                  print(imageUrl);
                  project.image = imageUrl;

                  FirebaseFirestore.instance
                      .collection('projects')
                      .doc(project.id)
                      .set(project.toJson());
                  return Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> _uploadImage({File file, String path}) async {
    print(file.path);
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    String ext = Path.basename(file.path).split('.')[1].toString();
    // String image = path + "_" + time + "." + ext;
    String image = time + "." + ext;

    final ref = FirebaseStorage.instance.ref().child(path + "/" + image);
    final task = ref.putFile(file);
    final snapshot = await task.onComplete;
    final String imageURL = (await snapshot.ref.getDownloadURL()).toString();

    return imageURL;
  }
}
