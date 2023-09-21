import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services//listeningto_audio.dart';

class AudioListCard extends StatefulWidget {
  const AudioListCard({
    super.key,
    required this.mypost,
  });

  final DocumentSnapshot<Object?> mypost;

  @override
  State<AudioListCard> createState() => _AudioListCardState();
}

class _AudioListCardState extends State<AudioListCard> {
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade800.withOpacity(0.6),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              'https://images.macrumors.com/t/vMbr05RQ60tz7V_zS5UEO9SbGR0=/1600x900/smart/article-new/2018/05/apple-music-note.jpg',
              height: 50,
              width: 50,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.mypost['person']}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isPlaying = !isPlaying;
              });
              if (isPlaying) {
                // Ses çalma işlemini başlat
                ListeningToAudio()
                    .playLinkAudio(widget.mypost['audio'])
                    .then((_) {
                  setState(() {
                    isPlaying =
                        false; // Ses çalma bittiğinde ikonu tekrar değiştir
                  });
                });
              } else {
                // Ses çalma işlemini durdur
                ListeningToAudio().stopAudio();
              }
            },
            icon: Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
