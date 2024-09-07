import 'package:blgym/train/pages/train_exercises_page.dart';
import 'package:blgym/train/pages/train_form_page.dart';
import 'package:blgym/train/train.dart';
import 'package:blgym/train/train_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrainPage extends StatelessWidget {
  const TrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trainController = Provider.of<TrainController>(context);
    trainController.fetchTrains();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trains'),
      ),
      body: ListView.builder(
        itemCount: trainController.trains.length,
        itemBuilder: (context, indexTrain) {
          final train = trainController.trains[indexTrain];
          return ListTile(
            title: Text(train.name),
            trailing: IconButton(
              onPressed: () => _navigateToTrainExercices(context, train),
              icon: const Icon(Icons.arrow_circle_right),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTrain(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  _navigateToAddTrain(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrainFormPage(),
      ),
    );
  }

  _navigateToTrainExercices(BuildContext context, Train train) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainExercisesPage(train: train),
      ),
    );
  }
}
