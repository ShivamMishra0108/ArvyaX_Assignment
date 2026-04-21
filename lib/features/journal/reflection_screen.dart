import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/models/ambience_model.dart';
import '../widgets/mood_selector.dart';
import '../widgets/primary_button.dart';
import 'journal_history_screen.dart';

class ReflectionScreen extends StatefulWidget {
  final Ambience ambience;

  const ReflectionScreen({super.key, required this.ambience});

  @override
  State<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen> {
  final TextEditingController _textController = TextEditingController();
  String? selectedMood;

  void _saveReflection() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reflection saved'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.accentMutedGreen,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const JournalHistoryScreen()),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B1F3A), Color(0xFF0E3A6D), Color(0xFF1976D2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,color: Colors.white,),
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text('Skip',style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),

                const SizedBox(height: AppTheme.spacing32),

                Text(
                  'What is gently present with you right now?',
                  style: AppTheme.heading1.copyWith(fontSize: 28, height: 1.3,color: Colors.white),
                ),

                const SizedBox(height: AppTheme.spacing8),

                Text(
                  'After ${widget.ambience.title}',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                ),

                const SizedBox(height: AppTheme.spacing32),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    boxShadow: AppTheme.softShadow,
                  ),
                  child: TextField(
                    controller: _textController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'I notice...',
                      hintStyle: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(AppTheme.spacing20),
                    ),
                    style: AppTheme.bodyLarge,
                  ),
                ),

                const SizedBox(height: AppTheme.spacing32),

                Text(
                  'How do you feel?',
                  style: AppTheme.heading3.copyWith(fontSize: 18),
                ),

                const SizedBox(height: AppTheme.spacing12),

                MoodSelector(
                  selectedMood: selectedMood,
                  onMoodSelected: (mood) {
                    setState(() {
                      selectedMood = mood;
                    });
                  },
                ),

                const SizedBox(height: AppTheme.spacing40),

                PrimaryButton(
                  text: 'Save Reflection',
                  onPressed:
                      selectedMood != null && _textController.text.isNotEmpty
                      ? _saveReflection
                      : () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
