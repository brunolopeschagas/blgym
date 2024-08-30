// lib/models/train.dart
import '../exercise/exercise.dart';

class Train {
  final int? id;
  final String name;
  List<Exercise>? exercises;

  Train({
    this.id,
    required this.name,
    this.exercises,
  });

  void addExercise(Exercise exercise) {
    exercises!.add(exercise);
  }

  factory Train.fromMap(Map<String, dynamic> json) => Train(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}
