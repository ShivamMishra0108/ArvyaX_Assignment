import 'package:aether_2/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../data/models/ambience_model.dart';
import 'reflection_screen.dart';

class SessionPlayerScreen extends ConsumerStatefulWidget {
  final Ambience ambience;

  const SessionPlayerScreen({super.key, required this.ambience});

  @override
  ConsumerState<SessionPlayerScreen> createState() =>
      _SessionPlayerScreenState();
}

class _SessionPlayerScreenState extends ConsumerState<SessionPlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;

  int selectedDuration = 0;

  int get totalDuration {
    final durationStr = widget.ambience.duration.split(' ')[0];
    return int.parse(durationStr) * 60;
  }

  int get activeDuration =>
      selectedDuration == 0 ? totalDuration : selectedDuration;

  @override
  void initState() {
    super.initState();

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(playerControllerProvider.notifier);
      final player = ref.read(playerControllerProvider);

      if (player.title == null) {
        controller.start(
          id: widget.ambience.id,
          title: widget.ambience.title,
          audio: widget.ambience.audio,
          durationSeconds: activeDuration,
          image: widget.ambience.imageUrl,
        );
      }
    });
  }

  Future<void> _pickDuration() async {
    final result = await showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            spacing: 10,
            children: [5, 10, 15, 20].map((min) {
              return ChoiceChip(
                label: Text("$min min"),
                selected: selectedDuration == min * 60,
                onSelected: (_) => Navigator.pop(context, min * 60),
              );
            }).toList(),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedDuration = result;
      });

      final controller = ref.read(playerControllerProvider.notifier);

      controller.start(
        id: widget.ambience.id,
        title: widget.ambience.title,
        audio: widget.ambience.audio,
        durationSeconds: selectedDuration,
        image: widget.ambience.imageUrl,
      );
    }
  }

  String _format(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return "${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerControllerProvider);
    final controller = ref.read(playerControllerProvider.notifier);

    final progress = player.duration.inSeconds == 0
        ? 0.0
        : player.position.inSeconds / player.duration.inSeconds;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(player.image!),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: AnimatedBuilder(
                  animation: _breathingController,
                  builder: (context, child) {
                    return Container(
                      width: 200 + (_breathingController.value * 50),
                      height: 200 + (_breathingController.value * 50),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.accentMutedGreen.withOpacity(0.1),
                            AppTheme.primaryIndigo.withOpacity(0.05),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.spacing20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacing40),
                        Text(
                          player.title ?? widget.ambience.title,
                          style: AppTheme.heading2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      IconButton(
                        iconSize: 72,
                        icon: Icon(
                          player.isPlaying
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          color: Colors.white,
                        ),
                        onPressed: controller.toggle,
                      ),
                      TextButton(
                        onPressed: _pickDuration,
                        child: Text(
                          selectedDuration == 0
                              ? "Set Timer"
                              : "${selectedDuration ~/ 60} min",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(AppTheme.spacing24),
                    child: Column(
                      children: [
                        Slider(value: progress, onChanged: controller.seek),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _format(player.position),
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              _format(player.duration),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            controller.stop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ReflectionScreen(ambience: widget.ambience),
                              ),
                            );
                          },
                          child: const Text(
                            "End Session",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
