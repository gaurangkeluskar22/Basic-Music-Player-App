import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';

class Songspage extends StatefulWidget {
  String song_name, artist_name, song_url, image_url;

  Songspage({this.song_name, this.artist_name, this.song_url, this.image_url});
  @override
  _SongspageState createState() => _SongspageState();
}

class _SongspageState extends State<Songspage> {
  MusicPlayer musicPlayer;
  bool isplaying1 = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Initializing the Music Player and adding a single [PlaylistItem]
  Future<void> initPlatformState() async {
    musicPlayer = MusicPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player App"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(
              widget.song_name,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              widget.artist_name,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Card(
              child: Image.network(widget.image_url, height: 350.0),
              elevation: 10.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                ),
                IconButton(
                  icon: Icon(isplaying1 ? Icons.pause:Icons.play_arrow),
                  iconSize: 60.0,
                  color: isplaying1? Colors.blue:Colors.black,
                  onPressed: (){
                    if(isplaying1){
                      musicPlayer.pause();

                      setState(() {
                        isplaying1=false;
                      }); 
                    }
                    else{
                          setState(() {
                            isplaying1=true;
                          });

                          musicPlayer.play(MusicItem(
                          trackName: widget.song_name==null?'':widget.song_name,
                          albumName: '',
                          artistName: widget.artist_name==null?'':widget.artist_name,
                          url: widget.song_url==null?'':widget.song_url,
                          coverUrl: widget.image_url==null?'':widget.image_url,
                          duration: Duration(seconds: 255),
                        ));
                    }
                  }),

                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.stop,
                  ), 
                  color: isplaying1?Colors.black:Colors.blue,
                  iconSize: 60.0,
                  onPressed: (){
                    musicPlayer.stop();
                    setState(() {
                      isplaying1=false;
                    });
                  }
                  ),

                SizedBox(
                  width: 100.0,
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
