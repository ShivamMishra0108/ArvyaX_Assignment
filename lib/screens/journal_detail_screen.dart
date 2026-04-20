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
      appBar: AppBar(
        title: const Text('Reflection'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM d, y').format(entry.timestamp),
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textTertiary,
              ),
            ),
            
            Text(
              DateFormat('h:mm a').format(entry.timestamp),
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textTertiary,
              ),
            ),
            
            const SizedBox(height: AppTheme.spacing24),
            
            Text(
              entry.ambienceTitle,
              style: AppTheme.heading2,
            ),
            
            const SizedBox(height: AppTheme.spacing12),
            
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing16,
                vertical: AppTheme.spacing8,
              ),
              decoration: BoxDecoration(
                color: _getMoodColor(entry.mood).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusPill),
              ),
              child: Text(
                entry.mood,
                style: AppTheme.bodyMedium.copyWith(
                  color: _getMoodColor(entry.mood),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            const SizedBox(height: AppTheme.spacing32),
            
            Container(
              height: 1,
              color: AppTheme.textTertiary.withOpacity(0.1),
            ),
            
            const SizedBox(height: AppTheme.spacing32),
            
            Text(
              entry.text,
              style: AppTheme.bodyLarge.copyWith(
                height: 1.8,
                fontSize: 18,
              ),
            ),
          ],
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
