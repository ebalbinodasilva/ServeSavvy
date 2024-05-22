import 'package:flutter/material.dart';
import 'package:flutter_application_servesavvy/src/core/widgets/video_player_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class VideoCapturePage extends StatefulWidget {
  @override
  _VideoCapturePageState createState() => _VideoCapturePageState();
}

class _VideoCapturePageState extends State<VideoCapturePage> {
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;

  Future<void> _captureVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String videoPath = '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
      final File newVideo = await File(video.path).copy(videoPath);

      setState(() {
        _videoFile = newVideo;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vídeo salvo em: ${newVideo.path}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capturar Vídeo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_videoFile != null)
              Column(
                children: [
                  Text('Vídeo capturado:'),
                  Container(
                    width: 200,
                    height: 200,
                    child: VideoPlayerWidget(videoFile: _videoFile!),
                  ),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureVideo,
              child: Text('Capturar Vídeo'),
            ),
          ],
        ),
      ),
    );
  }
}
