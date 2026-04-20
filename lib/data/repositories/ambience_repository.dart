import 'dart:convert';

import 'package:aether_2/data/models/ambience_model.dart';
import 'package:flutter/services.dart';

class AmbienceRepository {
  Future<List<Ambience>> loadAmbiences() async {
    final data = await rootBundle.loadString('assets/data/ambiences.json');
    final List decoded = json.decode(data);

    return decoded.map((e) => Ambience.fromJson(e)).toList();
  }
}