import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SensoryChip extends StatelessWidget {
  final String label;
  final IconData? icon;

  const SensoryChip({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing16,
        vertical: AppTheme.spacing8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.secondaryBeige,
        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        border: Border.all(
          color: AppTheme.textTertiary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: AppTheme.spacing4),
          ],
          Text(
            label,
            style: AppTheme.bodySmall.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
