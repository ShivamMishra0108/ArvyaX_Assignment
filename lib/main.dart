import 'package:aether_2/data/static_data/ambience_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'data/models/journal_entry.dart';
import 'data/models/ambience_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(AmbienceAdapter());
  Hive.registerAdapter(JournalEntryAdapter());

  final ambienceBox = await Hive.openBox<Ambience>('aetherBox');
  await Hive.openBox<JournalEntry>('journalBox');

  await Hive.openBox('playerBox');

  if (ambienceBox.isEmpty) {
    ambienceBox.addAll(AmbienceData.ambiences);
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    const ProviderScope( 
      child: AetherApp(),
    ),
  );
}

class AetherApp extends StatelessWidget {
  const AetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aether',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}