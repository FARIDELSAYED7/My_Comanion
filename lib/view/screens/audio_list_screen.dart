import 'package:flutter/material.dart';
import 'package:my_companionm/core/models/audiomodel.dart';
import 'audio_player_screen.dart';

class AudioListScreen extends StatelessWidget {
  final List<Audiomodel> musicList = [
    Audiomodel(
        description: "Birds At Morning",
        path: "audio/birds.mp3",
        title: "Calm"),
    Audiomodel(
        description: "Ocean Sound",
        path: "audio/oceansound.mp3",
        title: "Calm"),
    Audiomodel(
        description: "Heavy Rain", path: "audio/heavyrain.mp3", title: "Calm"),
    Audiomodel(
        description: "Birds At Morning",
        path: "audio/birds.mp3",
        title: "Calm"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/topimg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 10,
              ),
              child: Text(
                'Meditation List Title :',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final music = musicList[index];
                return Column(
                  children: [
                    const SizedBox(height: 14),
                    ListTile(
                      title: Text(music.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                      subtitle: Text(music.description,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          )),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioPlayerScreen(
                              category: music.title,
                              music: music,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              childCount: musicList.length,
            ),
          ),
        ],
      ),
    );
  }
}
