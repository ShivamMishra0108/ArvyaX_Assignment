import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/player_state.dart';

final playerControllerProvider =
    StateNotifierProvider<PlayerController, PlayerState>(
  (ref) => PlayerController(),
);

class PlayerController extends StateNotifier<PlayerState> {
  Timer? _timer;

  PlayerController() : super(PlayerState.initial()) {
    _restore();
  }
  void start({
    required String id, 
    required String title,
    required String audio,
    required int durationSeconds,
    required String image
  }) {
    _timer?.cancel();

    state = PlayerState(
      id: id, 
      isPlaying: true,
      position: Duration.zero,
      duration: Duration(seconds: durationSeconds),
      title: title,
      audio: audio,
      image: image
    );

    _runTimer();
    _save();
  }

  void _runTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final next = state.position + const Duration(seconds: 1);

      if (next >= state.duration) {
        _timer?.cancel();
        stop();
      } else {
        state = state.copyWith(position: next);
        _save();
      }
    });
  }

  void toggle() {
    if (state.isPlaying) {
      _timer?.cancel();
      state = state.copyWith(isPlaying: false);
    } else {
      state = state.copyWith(isPlaying: true);
      _runTimer();
    }
    _save();
  }

  void stop() {
    _timer?.cancel();
    state = PlayerState.initial();
    _clear();
  }

  void seek(double progress) {
    final newPos =
        Duration(seconds: (state.duration.inSeconds * progress).round());

    state = state.copyWith(position: newPos);
    _save();
  }

  Future<void> _save() async {
    final box = await Hive.openBox('playerBox');
    box.put('player', state.toMap());
  }

  Future<void> _restore() async {
    final box = await Hive.openBox('playerBox');
    final data = box.get('player');

    if (data != null) {
      state = PlayerState.fromMap(data);

      if (state.id != -1 && state.isPlaying) {
        _runTimer();
      }
    }
  }

  Future<void> _clear() async {
    final box = await Hive.openBox('playerBox');
    box.delete('player');
  }
}