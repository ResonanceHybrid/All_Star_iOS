// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:all_star_learning/new/features/videos/domain/entities/video_entity.dart';

class VideosState {
  final bool isLoading;
  final bool isSuccess;

  final List<VideoEntity> videos;

  final VideoEntity? selectedVideo;

  final bool isPlaying;
  VideosState({
    required this.isLoading,
    required this.isSuccess,
    required this.videos,
    this.selectedVideo,
    required this.isPlaying,
  });

  factory VideosState.initial() {
    return VideosState(
      isLoading: false,
      isSuccess: false,
      videos: <VideoEntity>[],
      selectedVideo: null,
      isPlaying: false,
    );
  }

  VideosState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<VideoEntity>? videos,
    ValueGetter<VideoEntity?>? selectedVideo,
    bool? isPlaying,
  }) {
    return VideosState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      videos: videos ?? this.videos,
      selectedVideo:
          selectedVideo != null ? selectedVideo() : this.selectedVideo,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_loading': isLoading,
      'is_success': isSuccess,
      'videos': videos.map((x) => x.toMap()).toList(),
      'selected_video': selectedVideo?.toMap(),
      'is_playing': isPlaying,
    };
  }

  factory VideosState.fromMap(Map<String, dynamic> map) {
    return VideosState(
      isLoading: map['is_loading'] ?? false,
      isSuccess: map['is_success'] ?? false,
      videos: List<VideoEntity>.from(
          map['videos']?.map((x) => VideoEntity.fromMap(x)) ?? const []),
      selectedVideo: map['selected_video'] != null
          ? VideoEntity.fromMap(map['selected_video'])
          : null,
      isPlaying: map['is_playing'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideosState.fromJson(String source) =>
      VideosState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VideosState(isLoading: $isLoading, isSuccess: $isSuccess, videos: $videos, selectedVideo: $selectedVideo, isPlaying: $isPlaying)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideosState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        listEquals(other.videos, videos) &&
        other.selectedVideo == selectedVideo &&
        other.isPlaying == isPlaying;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        videos.hashCode ^
        selectedVideo.hashCode ^
        isPlaying.hashCode;
  }
}
