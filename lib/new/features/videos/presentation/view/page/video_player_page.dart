import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GalleryVideoPlayer extends StatefulWidget {
  final String videoUrl; // Assume a single video URL is passed to the widget

  const GalleryVideoPlayer({super.key, required this.videoUrl});

  @override
  State<GalleryVideoPlayer> createState() => _GalleryVideoPlayerState();
}

class _GalleryVideoPlayerState extends State<GalleryVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late YoutubePlayerController _youtubePlayerController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeAndPlayVideo();
  }

  Future<void> _initializeAndPlayVideo() async {
    if (widget.videoUrl.contains('youtube.com')) {
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
      setState(() {
        _isInitialized = true;
      });
      return;
    } else {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      try {
        await _videoPlayerController.initialize();
        setState(() {
          _isInitialized = true;
        });
        _videoPlayerController.play();
      } catch (e) {
        log("Error initializing video player: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isInitialized
            ? widget.videoUrl.contains('youtube.com')
                ? YoutubePlayer(controller: _youtubePlayerController)
                : AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    if (_isInitialized) {
      if (widget.videoUrl.contains('youtube.com')) {
        _youtubePlayerController.dispose();
      } else {
        _videoPlayerController.dispose();
      }
    }

    super.dispose();
  }
}
