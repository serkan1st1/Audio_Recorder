import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioRecordPage extends StatefulWidget {
  const AudioRecordPage({super.key, required this.title});

  final String title;

  @override
  State<AudioRecordPage> createState() => _AudioRecordPageState();
}

class _AudioRecordPageState extends State<AudioRecordPage> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
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

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop(); //the returns output path
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print('Error Stopping record: $e');
    }
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = DeviceFileSource(audioPath);
      print('$audioPath');
      await audioPlayer.play(urlSource);

      print('$audioPath');
      await audioPlayer.play(urlSource);
    } catch (e) {
      print('Error playin Recording : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isRecording)
              const Text(
                'Recording in Progress',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ElevatedButton(
              onPressed: isRecording ? stopRecording : startRecording,
              child: isRecording
                  ? const Text('Stop Recording')
                  : const Text('Start recording'),
            ),
            const SizedBox(
              height: 25,
            ),
            if (!isRecording && audioPath != null)
              ElevatedButton(
                onPressed: playRecording,
                child: Text('Play Recording'),
              ),
          ],
        ),
      ),
    );
  }
}
