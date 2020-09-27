import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/screens/Songspage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DocumentSnapshot> _list;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('songs')
          .orderBy('song_name')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          _list = snapshot.data.docs;

          return ListView.custom(
              childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return buildList(context, _list[index]);
            },
            childCount: _list.length,
          ));
        }
      },
    );
  }

  Widget buildList(BuildContext context, DocumentSnapshot documentSnapshot) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Songspage(
                    song_name: documentSnapshot.data()["song_name"],
                    artist_name: documentSnapshot.data()["artist_name"],
                    song_url: documentSnapshot.data()["song_url"],
                    image_url: documentSnapshot.data()["image_url"],
                  ))),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            documentSnapshot.data()["song_name"],
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        elevation: 10.0,
      ),
    );
  }
}
