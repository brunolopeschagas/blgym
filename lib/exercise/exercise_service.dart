// lib/services/exercise_service.dart
import 'exercise.dart';
import '../shared/db/database_helper.dart';

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
    final List<Exercise> exercises =
        result.map((map) => Exercise.fromMap(map)).toList();
    return exercises;
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

  Future<List<Exercise>> getAllTrainExercises(int trainId) async {
    final db = await _dbHelper.database;

    const String sql = """
      SELECT e.* FROM exercises e
      INNER JOIN train_exercises te ON e.id = te.exercise_id
      WHERE te.train_id = ?
    """;

    final List<Map<String, Object?>> resultQuery =
        await db.rawQuery(sql, [trainId]);

    List<Exercise> exercises =
        resultQuery.map((e) => Exercise.fromMap(e)).toList();

    return exercises;
  }
}
