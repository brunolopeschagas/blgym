import 'package:blgym/train/pages/train_form_page.dart';
import 'package:flutter/material.dart';

class TrainPage extends StatelessWidget {
  const TrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trains'),
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
}
