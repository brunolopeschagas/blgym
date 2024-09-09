import 'package:blgym/train/train_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrainDeleteDialog extends StatelessWidget {
  final int trainId;

  const TrainDeleteDialog({super.key, required this.trainId});

  @override
  Widget build(BuildContext context) {
    final trainController = Provider.of<TrainController>(context);
    return AlertDialog(
      title: const Text('Delete this train?'),
      content: const Text('No turning back here!'),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No')),
        ElevatedButton(
            onPressed: () {
              trainController.deleteTrain(trainId);
              Navigator.pop(context);
            },
            child: const Text('Yes')),
      ],
    );
  }
}
