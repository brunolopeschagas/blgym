// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blgym/exercise/exercise.dart';
import 'package:blgym/exercise/exercise_controller.dart';
import 'package:blgym/train/train_controller.dart';
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
    final trainController = context.read<TrainController>();
    final exerciseController = context.read<ExerciseController>();
    if (exerciseController.exercises.isEmpty) {
      exerciseController.fetchTrainExercises(_train.id ?? 0);
    }
    if (trainController.trains.isEmpty) {
      trainController.fetchTrains();
    }
    print('loading train exercises');

    return Consumer(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Train: ${_train.name}'),
        ),
        body: ListView.builder(
          itemCount: exerciseController.exercises.length,
          itemBuilder: (context, index) {
            final Exercise exercise = exerciseController.exercises[index];
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text('Whats now?'),
                      children: [
                        SimpleDialogOption(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 30),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        SimpleDialogOption(
                            child: const Text(
                              'Remove',
                              style: TextStyle(fontSize: 30),
                            ),
                            onPressed: () {
                              trainController.removeExercise(
                                  _train.id!, exercise.id!);
                              exerciseController
                                  .fetchTrainExercises(_train.id!);
                              Navigator.of(context).pop();
                            }),
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                title: Text(
                  exercise.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: Text(
                  exercise.description!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                trailing: Text(
                  '${exercise.series} x ${exercise.cargo}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
