// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/controllers/exercise_controller.dart
import 'package:flutter/material.dart';

import 'exercise.dart';
import 'exercise_service.dart';

class ExerciseController with ChangeNotifier {
  final ExerciseService _exerciseService = ExerciseService();
  List<Exercise> _exercises = [];

  List<Exercise> get exercises => _exercises;

  Future<void> fetchExercises() async {
    print('listing exercises');
    _exercises = await _exerciseService.getAllExercises();
    notifyListeners();
  }

  Future<void> fetchTrainExercises(int trainId) async {
    print('listing train exercises');
    _exercises = await _exerciseService.getAllTrainExercises(trainId);
    notifyListeners();
  }

  Future<void> addExercise(Exercise exercise) async {
    await _exerciseService.addExercise(exercise);
    await fetchExercises();
  }

  Future<void> updateExercise(Exercise exercise) async {
    await _exerciseService.updateExercise(exercise);
    await fetchExercises();
  }

  Future<void> deleteExercise(int id) async {
    await _exerciseService.deleteExercise(id);
    await fetchExercises();
  }
}
