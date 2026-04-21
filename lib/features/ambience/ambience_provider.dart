import 'package:aether_2/data/models/ambience_model.dart';
import 'package:aether_2/data/repositories/ambience_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ambienceProvider =
    StateNotifierProvider<AmbienceController, List<Ambience>>(
        (ref) => AmbienceController());

class AmbienceController extends StateNotifier<List<Ambience>> {
  AmbienceController() : super([]) {
    load();
  }

  Future<void> load() async {
    final repo = AmbienceRepository();
     state = await repo.loadAmbiences();
  }
}