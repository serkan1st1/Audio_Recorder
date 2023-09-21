import 'dart:io';
import 'package:audio_recorder/services/record_cstore_service.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_recorder/utils/generalColors.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum AudioState { begin, recording, stop, play }

class AudioRecordPage extends StatefulWidget {
  const AudioRecordPage({super.key});

  @override
  State<AudioRecordPage> createState() => _AudioRecordPageState();
}

class _AudioRecordPageState extends State<AudioRecordPage> {
  RecordService _recordService = RecordService();

  String personn = "Person Deneme";
  AudioState audioState = AudioState.begin;
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  String audioPath = '';
  late File _audioFile;
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioRecord.dispose();
    super.dispose();
  }

  void handleAudioState(AudioState state) {
    setState(() {
      if (audioState == AudioState.begin) {
        // Starts recording
        audioState = AudioState.recording;
        startRecording();
        // Finished recording
      } else if (audioState == AudioState.recording) {
        audioState = AudioState.play;
        stopRecording();
        // Play recorded audio
      } else if (audioState == AudioState.play) {
        audioState = AudioState.stop;
        playAudio().then((_) {
          setState(() => audioState = AudioState.play);
        });
        // Stop recorded audio
      } else if (audioState == AudioState.stop) {
        audioState = AudioState.play;
        stopAudio();
      }
    });
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop(); //the returns output path
      setState(() {
        audioPath = path!;
      });
    } catch (e) {
      print('Error Stopping record: $e');
    }
  }

  Future<void> playAudio() async {
    try {
      Source urlSource = DeviceFileSource(audioPath);
      print('$audioPath');
      await audioPlayer.play(urlSource);
    } catch (e) {
      print('Error playin Recording : $e');
    }
  }

  Future<void> stopAudio() async {
    try {
      await audioPlayer.setReleaseMode(ReleaseMode.release);
    } catch (e) {
      print('Error playin Recording : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: handleAudioColour(),
                ),
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(30),
                  onPressed: () => handleAudioState(audioState),
                  child: getIcon(audioState),
                ),
              ),
              SizedBox(width: 10),
              if (audioState == AudioState.play ||
                  audioState == AudioState.stop)
                Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: GeneralColors.kindaDarkBlue,
                  ),
                  child: RawMaterialButton(
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    onPressed: () => setState(() {
                      audioState = AudioState.begin;
                    }),
                    child: Icon(Icons.replay, size: 50),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          if (audioState == AudioState.play || audioState == AudioState.stop)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: GeneralColors.kindaDarkBlue,
                  ),
                  child: RawMaterialButton(
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    onPressed: () {
                      _recordService
                          .addRecord(personn, audioPath)
                          .then((value) {
                        Fluttertoast.showToast(msg: "Successful");
                      });
                    },
                    child: Icon(Icons.save, size: 50),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Color handleAudioColour() {
    if (audioState == AudioState.recording) {
      return Colors.deepOrangeAccent.shade700.withOpacity(0.5);
    } else if (audioState == AudioState.stop) {
      return Colors.green.shade900;
    } else {
      return GeneralColors.kindaDarkBlue;
    }
  }

  Icon getIcon(AudioState state) {
    switch (state) {
      case AudioState.play:
        return Icon(Icons.play_arrow, size: 50);
      case AudioState.stop:
        return Icon(Icons.stop, size: 50);
      case AudioState.recording:
        return Icon(Icons.mic, color: Colors.redAccent, size: 50);
      default:
        return Icon(Icons.mic, size: 50);
    }
  }
}
