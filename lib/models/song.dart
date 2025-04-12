import 'dart:collection';

class Song {
  final String title;
  final String keyNote;
  final String scaleType;
  final String progression;
  final double? tempo;

  /// Constructor
  Song({
    required this.title,
    required this.keyNote,
    required this.scaleType,
    required this.progression,
    required this.tempo,
  });
}
