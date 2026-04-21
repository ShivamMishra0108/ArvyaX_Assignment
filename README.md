#  Aether 

  Ambient Mindfulness & Reflection App assignment from ArvyaX.

---

##  Screens

- **Home Screen** — Ambience selection + filters  
- **Ambience Detail Screen** — Play session  
- **Mini Player** — Persistent control  
- **Reflection Screen** — Journaling + mood  
- **Journal History Screen** — View saved reflections
- **Session Player Screen**

---

##  Tech Stack

- **Flutter** — UI Framework  
- **Dart**  
- **Riverpod** — State Management  
- **Hive** — Local Storage  
- **just_audio** — Audio Playback  

---

##  Features

###  Ambient Sound Experience
- Curated ambient environments (rain, forest, ocean, etc.)
- Smooth audio playback with real-time controls
- Mini player for quick access
- Seamless session handling

###  Reflection System
- Post-session reflection screen
- Guided journaling prompts
- Mood selection system
- Save and revisit past reflections

###  Premium UI/UX

- Premium gradient themes (calm, mindfulness, sunset tones)  
- Transparent & Glassmorphism  
- Custom buttons with shadows and depth  
- Improved readability with dynamic contrast  
- Clean typography using centralized `AppTheme`
- Smooth transitions and animations
- Responsive layout for all screen sizes

---

## 📂 Project Structure

```bash
LIB
│   main.dart
│   
├───data
│   ├───models
│   │       ambience_model.dart
│   │       ambience_model.g.dart
│   │       journal_entry.dart
│   │       journal_entry.g.dart
│   │       player_state.dart
│   │       
│   ├───repositories
│   │       ambience_repository.dart
│   │       journal_repository.dart
│   │       
│   └───static_data
│           ambience_data.dart
│           journal_data.dart
│           
├───features
│   ├───ambience
│   │       ambience_card.dart
│   │       ambience_details_screen.dart
│   │       ambience_provider.dart
│   │       
│   ├───journal
│   │       journal_controller.dart
│   │       journal_detail_screen.dart
│   │       journal_history_screen.dart
│   │       reflection_screen.dart
│   │       
│   └───player
│           player_controller.dart
│           session_player_screen.dart
│           
├───screens
│       home_screen.dart
│       
└───shared
    ├───theme
    │       app_theme.dart
    │       
    └───widgets
            custom_chip.dart
            filter_chip_widget.dart
            mini_player.dart
            mood_selector.dart
            primary_button.dart
            sensory_chip.dart
