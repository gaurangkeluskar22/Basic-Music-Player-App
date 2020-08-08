import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/screens/Songspage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getdata() async {
    QuerySnapshot qn =
        await Firestore.instance.collection('songs').getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getdata(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Songspage(
                    song_name:snapshot.data[index].data["song_name"],
                    artist_name:snapshot.data[index].data["artist_name"],
                    song_url:snapshot.data[index].data["song_url"],
                    image_url:snapshot.data[index].data["image_url"],
                  ))),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                        child: Text(
                        snapshot.data[index].data["song_name"],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    elevation:10.0,
                  ),
                );
              });
        }
      },
    );
  }
}
