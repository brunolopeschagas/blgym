// lib/services/train_service.dart
import 'train.dart';
import '../exercise/exercise.dart';
import '../shared/db/database_helper.dart';

class TrainService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> addTrain(Train train) async {
    final db = await _dbHelper.database;
    final trainId = await db.insert('trains', train.toMap());

    if (train.exercises != null) {
      for (var exercise in train.exercises!) {
        await db.insert('train_exercises', {
          'train_id': trainId,
          'exercise_id': exercise.id,
        });
      }
    }

    return trainId;
  }

  Future<Train?> getTrain(int id) async {
    final db = await _dbHelper.database;

    final trainMap = await db.query(
      'trains',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (trainMap.isEmpty) return null;

    final exercisesMap = await db.rawQuery('''
      SELECT e.* FROM exercises e
      INNER JOIN train_exercises te ON e.id = te.exercise_id
      WHERE te.train_id = ?
    ''', [id]);

    final exercises = exercisesMap.map((e) => Exercise.fromMap(e)).toList();
    final Train train = Train.fromMap(trainMap.first);
    train.exercises!.addAll(exercises);

    return train;
  }

  Future<List<Train>> getAllTrains() async {
    final db = await _dbHelper.database;
    final trainsQueryResult = await db.query('trains');

    final List<Train> trains =
        trainsQueryResult.map((map) => Train.fromMap(map)).toList();
    return trains;
  }

  Future<int> updateTrain(Train train) async {
    final db = await _dbHelper.database;

    await db.update(
      'trains',
      train.toMap(),
      where: 'id = ?',
      whereArgs: [train.id],
    );

    // Delete existing train_exercises entries
    await db.delete(
      'train_exercises',
      where: 'train_id = ?',
      whereArgs: [train.id],
    );

    // Insert new train_exercises entries
    if (train.exercises != null) {
      for (var exercise in train.exercises!) {
        await db.insert('train_exercises', {
          'train_id': train.id,
          'exercise_id': exercise.id,
        });
      }
    }

    return train.id!;
  }

  Future<int> deleteTrain(int id) async {
    final db = await _dbHelper.database;

    // Deleting train will automatically delete related entries in train_exercises due to foreign key constraints
    return await db.delete(
      'trains',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> removeExercise(int trainId, int exerciseId) async {
    final db = await _dbHelper.database;
    return await db.delete('train_exercises',
        where: 'exercise_id = ? AND train_id = ?',
        whereArgs: [exerciseId, trainId]);
  }
}
