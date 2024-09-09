// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blgym/exercise/exercise.dart';
import 'package:blgym/exercise/exercise_controller.dart';
import 'package:flutter/material.dart';

import 'package:blgym/train/train.dart';
import 'package:provider/provider.dart';

class TrainExercisesPage extends StatefulWidget {
  final Train train;

  const TrainExercisesPage({
    super.key,
    required this.train,
  });

  @override
  State<TrainExercisesPage> createState() => _TrainExercisesPageState();
}

class _TrainExercisesPageState extends State<TrainExercisesPage> {
  late Train _train;

  @override
  void initState() {
    super.initState();
    _train = widget.train;
  }

  @override
  Widget build(BuildContext context) {
    final exerciseController = Provider.of<ExerciseController>(context);
    exerciseController.fetchTrainExercises(_train.id ?? 0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Train: ${_train.name}'),
      ),
      body: ListView.builder(
        itemCount: exerciseController.exercises.length,
        itemBuilder: (context, index) {
          final Exercise exercise = exerciseController.exercises[index];
          return ListTile(
            title: Text(
              exercise.name,
            ),
          );
        },
      ),
    );
  }
}
