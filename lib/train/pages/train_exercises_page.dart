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
    final trainController = context.read<TrainController>();
    final exerciseController = context.read<ExerciseController>();
    exerciseController.fetchTrainExercises(_train.id ?? 0);
    trainController.fetchTrains();
  }

  @override
  Widget build(BuildContext context) {
    final exerciseController = Provider.of<ExerciseController>(context);
    final trainController = Provider.of<TrainController>(context);

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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${exercise.series} x ${exercise.cargo}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
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
                                  removeExerciseFromTrain(trainController,
                                      exercise, exerciseController);
                                  Navigator.of(context).pop();
                                }),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void removeExerciseFromTrain(TrainController trainController,
      Exercise exercise, ExerciseController exerciseController) {
    trainController.removeExercise(_train.id!, exercise.id!);
    exerciseController.fetchTrainExercises(_train.id!);
  }
}
