import 'package:flutter/material.dart';
import '../features/video_capture/presentation/pages/video_capture_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Capture App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoCapturePage(),
    );
  }
}
