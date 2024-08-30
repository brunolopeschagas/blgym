// lib/services/exercise_service.dart
import 'exercise.dart';
import '../shared/database_helper.dart';

class ExerciseService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> addExercise(Exercise exercise) async {
    final db = await _dbHelper.database;
    return await db.insert('exercises', exercise.toMap());
  }

  Future<Exercise?> getExercise(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Exercise.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Exercise>> getAllExercises() async {
    final db = await _dbHelper.database;
    final result = await db.query('exercises');

    return result.map((map) => Exercise.fromMap(map)).toList();
  }

  Future<int> updateExercise(Exercise exercise) async {
    final db = await _dbHelper.database;
    return await db.update(
      'exercises',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<int> deleteExercise(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
