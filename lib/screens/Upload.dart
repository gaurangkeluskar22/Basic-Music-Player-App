import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController songname = TextEditingController();
  TextEditingController artistname = TextEditingController();

  File image, song;
  String imagepath, songpath;
  StorageReference ref;
  var image_down_url, song_down_url;
  final firestoreinstance = Firestore.instance;

  void selectimage() async {
    image = await FilePicker.getFile();

    setState(() {
      image = image;
      imagepath = basename(image.path);
      uploadimagefile(image.readAsBytesSync(), imagepath);
    });
  }

  Future<String> uploadimagefile(List<int> image, String imagepath) async {
    ref = FirebaseStorage.instance.ref().child(imagepath);
    StorageUploadTask uploadTask = ref.putData(image);

    image_down_url = await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  void selectsong() async {
    song = await FilePicker.getFile();

    setState(() {
      song = song;
      songpath = basename(song.path);
      uploadsongfile(song.readAsBytesSync(), songpath);
    });
  }

  Future<String> uploadsongfile(List<int> song, String songpath) async {
    ref = FirebaseStorage.instance.ref().child(songpath);
    StorageUploadTask uploadTask = ref.putData(song);

    song_down_url = await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  finalupload(context) {
    if(songname.text!=''   && song_down_url!=null && image_down_url!=null){
      print(songname.text);
      print(artistname.text);
      print(song_down_url);
      print(image_down_url.toString());

    var data = {
      "song_name": songname.text,
      "artist_name": artistname.text,
      "song_url": song_down_url.toString(),
      "image_url": image_down_url.toString(),
    };

    firestoreinstance
        .collection("songs")
        .document()
        .setData(data)
        .whenComplete(() => showDialog(
              context: context,
              builder: (context) => _onTapButton(context,"Files Uploaded Successfully :)"),
            ));
    }
    else{
        showDialog(
              context: context,
              builder: (context) => _onTapButton(context,"Please Enter All Details :("),
            );
    }
  }

  _onTapButton(BuildContext context,data) {
    return AlertDialog(title: Text(data));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () => selectimage(),
          child: Text("Select Image"),
        ),
        RaisedButton(
          onPressed: () => selectsong(),
          child: Text("Select Song"),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: TextField(
            controller: songname,
            decoration: InputDecoration(
              hintText: "Enter song name",
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: TextField(
            controller: artistname,
            decoration: InputDecoration(
              hintText: "Enter artist name",
            ),
          ),
        ),
        RaisedButton(
          onPressed: () => finalupload(context),
          child: Text("Upload"),
        ),
      ],
    ));
  }
}
