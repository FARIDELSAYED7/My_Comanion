import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_companionm/core/models/audiomodel.dart';

class AudioPlayerScreen extends StatefulWidget {
  final Audiomodel music;
  final String category;

  const AudioPlayerScreen(
      {Key? key, required this.music, required this.category})
      : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _player;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.category == 'Noise Off' || widget.category == 'Focus'
              ? widget.category
              : widget.music.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset('assets/images/homescreen.png').image,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             
              ElevatedButton(
                onPressed: () async {
                  if (isPlaying) {
                    await _player.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    await _player.play(
                      AssetSource(widget.music.path),
                    );
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: AnimatedOpacity(
                  opacity: isPlaying ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    isPlaying ? 'Pause' : 'Play',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
