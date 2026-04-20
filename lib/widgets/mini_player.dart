import 'dart:typed_data';

import 'package:aether_2/controllers/player_controller.dart';
import 'package:aether_2/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/session_player_screen.dart';
import '../data/models/ambience_model.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerControllerProvider);
    final controller = ref.read(playerControllerProvider.notifier);

    if (player.id == -1) {
      return const SizedBox.shrink();
    }

    final progress = player.duration.inSeconds == 0
        ? 0.0
        : player.position.inSeconds / player.duration.inSeconds;

    return GestureDetector(
      onTap: () {
        final ambience = Ambience(
          id: player.id,
          title: player.title ?? '',
          audio: player.audio ?? '',
          duration: "${player.duration.inMinutes} min",
          tag: "Focus",
          imageUrl: "",
          description: "",
          sensoryElements: [],
          category: "",
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SessionPlayerScreen(ambience: ambience),
          ),
        );
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
                colors: [
                   Color(0xFF1976D2),
                  Color(0xFF0B1F3A),
                  Color(0xFF0E3A6D),
                 
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
            ),

            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      width: 50,
                      height: 50,
                      child: player.image == null? Icon(Icons.image,color: Colors.white,): Image.network(player.image!)
                    ),
                  ),
                  Expanded(
                    child: Text(
                      player.title ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  
                  IconButton(
                    icon: Icon(
                      player.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: controller.toggle,
                  ),

                  
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: controller.stop,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}