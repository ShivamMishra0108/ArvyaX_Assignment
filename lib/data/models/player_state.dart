import 'package:flutter/material.dart';

class PlayerState {
  final String id; 
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String? title;
  final String? audio;
  final String? image;

  const PlayerState({
    required this.id,
    required this.isPlaying,
    required this.position,
    required this.duration,
    this.title,
    this.audio,
    this.image
  });

  PlayerState copyWith({
    String? id,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    String? title,
    String? audio,
    String? image,
  }) {
    return PlayerState(
      id: id ?? this.id,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      audio: audio ?? this.audio,
      image: image?? this.image
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isPlaying': isPlaying,
      'position': position.inSeconds,
      'duration': duration.inSeconds,
      'title': title,
      'audio': audio,
      'image': image,
      
    };
  }

  factory PlayerState.fromMap(Map map) {
    return PlayerState(
      id: map['id'] ?? -1,
      isPlaying: map['isPlaying'] ?? false,
      position: Duration(seconds: map['position'] ?? 0),
      duration: Duration(seconds: map['duration'] ?? 0),
      title: map['title'],
      audio: map['audio'],
      image: map['image'],
    );
  }

  factory PlayerState.initial() {
    return const PlayerState(
      id: "", 
      isPlaying: false,
      position: Duration.zero,
      duration: Duration.zero,
    );
  }
}