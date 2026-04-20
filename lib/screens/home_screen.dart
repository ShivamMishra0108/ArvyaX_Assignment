import 'dart:ui';
import 'package:aether_2/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../theme/app_theme.dart';
import '../data/models/ambience_model.dart';
import '../widgets/ambience_card.dart';
import '../widgets/mini_player.dart';
import 'ambience_details_screen.dart';
import 'journal_history_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<String> categories = ['All', 'Focus', 'Calm', 'Sleep', 'Reset'];

  String selectedCategory = 'All';
  String searchQuery = '';

  List<Ambience> get filteredAmbiences {
    final box = Hive.box<Ambience>('aetherBox');
    var filtered = box.values.toList();

    if (selectedCategory != 'All') {
      filtered = filtered.where((a) => a.category == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (a) =>
                a.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                a.description.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredAmbiences;

    final player = ref.watch(playerControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B1F3A),
                  Color(0xFF0E3A6D),
                  Color(0xFF1976D2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Aether',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.person_outline),
                            onPressed: () {},
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: const Icon(Icons.history),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const JournalHistoryScreen(),
                                ),
                              );
                            },
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search ambiences...',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected
                                ? Colors.blueAccent
                                : Colors.white.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: filtered.isEmpty
                      ? _buildEmptyState()
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final ambience = filtered[index];

                            return AmbienceCard(
                              ambience: ambience,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AmbienceDetailsScreen(
                                      ambience: ambience,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),

         
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: (player.id != -1 && player.title != null)
                  ? const Padding(
                      key: ValueKey('mini_player'),
                      padding: EdgeInsets.only(bottom: 8),
                      child: MiniPlayer(),
                    )
                  : const SizedBox(key: ValueKey('empty')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 64, color: Colors.white54),
          const SizedBox(height: 16),
          const Text(
            'No ambiences found',
            style: TextStyle(color: Colors.white70),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedCategory = 'All';
                searchQuery = '';
              });
            },
            child: const Text(
              'Clear Filters',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
