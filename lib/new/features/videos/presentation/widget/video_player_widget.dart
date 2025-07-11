import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
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
    return SizedBox(
      width: 1.sw,
      height: 200.h,
      child: Center(
        child: _isInitialized
            ? Stack(
                children: [
                  widget.videoUrl.contains('youtube.com')
                      ? YoutubePlayer(controller: _youtubePlayerController)
                      : AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                ],
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
