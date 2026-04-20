import 'package:aether_2/data/static_data/journal_data.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/models/journal_entry.dart';
import 'journal_detail_screen.dart';
import 'package:intl/intl.dart';


class JournalHistoryScreen extends StatelessWidget {
  const JournalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = JournalData.entries;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reflections'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: entries.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(AppTheme.spacing20),
              itemCount: entries.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppTheme.spacing12),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return _JournalEntryCard(
                  entry: entry,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JournalDetailScreen(
                          entry: entry,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories_outlined,
              size: 64,
              color: AppTheme.textTertiary.withOpacity(0.5),
            ),
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'No reflections yet',
              style: AppTheme.heading3.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Start a session to begin.',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _JournalEntryCard extends StatelessWidget {
  final JournalEntry entry;
  final VoidCallback onTap;

  const _JournalEntryCard({
    required this.entry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          boxShadow: AppTheme.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('MMM d, y · h:mm a').format(entry.timestamp),
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing12,
                    vertical: AppTheme.spacing4,
                  ),
                  decoration: BoxDecoration(
                    color: _getMoodColor(entry.mood).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                  ),
                  child: Text(
                    entry.mood,
                    style: AppTheme.caption.copyWith(
                      color: _getMoodColor(entry.mood),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacing8),
            
            Text(
              entry.ambienceTitle,
              style: AppTheme.heading3.copyWith(fontSize: 16),
            ),
            
            const SizedBox(height: AppTheme.spacing8),
            
            Text(
              entry.text,
              style: AppTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
