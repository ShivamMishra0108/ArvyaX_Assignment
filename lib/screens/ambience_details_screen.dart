import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/models/ambience_model.dart';
import '../widgets/primary_button.dart';
import '../widgets/sensory_chip.dart';
import 'session_player_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AmbienceDetailsScreen extends StatelessWidget {
  final Ambience ambience;

  const AmbienceDetailsScreen({
    super.key,
    required this.ambience,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: AppTheme.backgroundOffWhite,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.softShadow,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: ambience.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.secondaryBeige,
                    ),
                  ),
                ),
              ),
              
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacing24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              ambience.title,
                              style: AppTheme.heading1.copyWith(fontSize: 28),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacing12,
                              vertical: AppTheme.spacing8,
                            ),
                            decoration: BoxDecoration(
                              color: _getTagColor(ambience.tag).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                            ),
                            child: Text(
                              ambience.tag,
                              style: AppTheme.caption.copyWith(
                                color: _getTagColor(ambience.tag),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: AppTheme.spacing8),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: AppTheme.textTertiary,
                          ),
                          const SizedBox(width: AppTheme.spacing4),
                          Text(
                            ambience.duration,
                            style: AppTheme.bodyMedium,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: AppTheme.spacing24),
                      
                      Text(
                        ambience.description,
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textSecondary,
                          height: 1.6,
                        ),
                      ),
                      
                      const SizedBox(height: AppTheme.spacing32),
                      
                      Text(
                        'Sensory Elements',
                        style: AppTheme.heading3.copyWith(fontSize: 18),
                      ),
                      
                      const SizedBox(height: AppTheme.spacing12),
                      
                      Wrap(
                        spacing: AppTheme.spacing8,
                        runSpacing: AppTheme.spacing8,
                        children: ambience.sensoryElements
                            .map((element) => SensoryChip(label: element))
                            .toList(),
                      ),
                      
                      const SizedBox(height: 120), 
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spacing20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.backgroundOffWhite.withOpacity(0),
                    AppTheme.backgroundOffWhite,
                    AppTheme.backgroundOffWhite,
                  ],
                ),
              ),
              child: SafeArea(
                top: false,
                child: PrimaryButton(
                  text: 'Start Session',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessionPlayerScreen(
                          ambience: ambience,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getTagColor(String tag) {
    switch (tag) {
      case 'Focus':
        return AppTheme.primaryIndigo;
      case 'Calm':
        return AppTheme.accentMutedGreen;
      case 'Sleep':
        return AppTheme.accentLavender;
      case 'Reset':
        return const Color(0xFFE89B6C);
      default:
        return AppTheme.textSecondary;
    }
  }
}
