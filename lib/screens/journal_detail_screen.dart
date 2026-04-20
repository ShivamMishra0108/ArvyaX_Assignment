import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../data/models/journal_entry.dart';

class JournalDetailScreen extends StatelessWidget {
  final JournalEntry entry;

  const JournalDetailScreen({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text(
          'Reflection',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1976D2),
              Color(0xFF64B5F6), 
              Color(0xFFE3F2FD), 
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MMMM d, y').format(entry.timestamp),
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('h:mm a').format(entry.timestamp),
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: AppTheme.spacing24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacing20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusLarge),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.ambienceTitle,
                        style: AppTheme.heading2.copyWith(
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacing12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing16,
                          vertical: AppTheme.spacing8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              _getMoodColor(entry.mood).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(
                              AppTheme.radiusPill),
                        ),
                        child: Text(
                          entry.mood,
                          style: AppTheme.bodyMedium.copyWith(
                            color: _getMoodColor(entry.mood),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacing24),

                      Divider(
                        color: Colors.grey.withOpacity(0.3),
                        thickness: 1,
                      ),

                      const SizedBox(height: AppTheme.spacing24),

                      /// Content
                      Text(
                        entry.text,
                        style: AppTheme.bodyLarge.copyWith(
                          height: 1.8,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Calm':
        return AppTheme.accentMutedGreen;
      case 'Grounded':
        return const Color(0xFF8B7355);
      case 'Energized':
        return const Color(0xFFE89B6C);
      case 'Sleepy':
        return AppTheme.accentLavender;
      default:
        return AppTheme.textSecondary;
    }
  }
}