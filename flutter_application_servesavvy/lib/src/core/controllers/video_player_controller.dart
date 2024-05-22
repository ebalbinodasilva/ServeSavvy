import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class CustomVideoPlayerController extends ChangeNotifier {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;
  bool _isDisposed = false;

  bool get isPlaying => _isPlaying;
  bool get isInitialized => _isInitialized;

  VideoPlayerController get controller => _controller;

  Future<void> initialize(File videoFile) async {
    _controller = VideoPlayerController.file(videoFile)
      ..addListener(() {
        if (_isDisposed) return;
        if (_controller.value.isInitialized != _isInitialized) {
          _isInitialized = _controller.value.isInitialized;
          notifyListeners();
        }
        if (_controller.value.isPlaying != _isPlaying) {
          _isPlaying = _controller.value.isPlaying;
          notifyListeners();
        }
      })
      ..initialize().then((_) {
        _isInitialized = true;
        notifyListeners();
      });
  }

  void play() {
    _controller.play();
  }

  void pause() {
    _controller.pause();
  }

  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }
}
