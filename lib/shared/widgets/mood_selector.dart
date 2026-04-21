import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MoodSelector extends StatelessWidget {
  final List<String> moods = const ['Calm', 'Grounded', 'Energized', 'Sleepy'];
  final String? selectedMood;
  final Function(String) onMoodSelected;

  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppTheme.spacing8,
      runSpacing: AppTheme.spacing8,
      children: moods.map((mood) {
        final isSelected = mood == selectedMood;
        return GestureDetector(
          onTap: () => onMoodSelected(mood),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing20,
              vertical: AppTheme.spacing12,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryIndigo : Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primaryIndigo
                    : AppTheme.textTertiary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              mood,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : AppTheme.textSecondary,
                letterSpacing: 0.2,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
