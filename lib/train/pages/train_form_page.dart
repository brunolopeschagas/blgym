import 'package:blgym/exercise/exercise.dart';
import 'package:blgym/exercise/exercise_controller.dart';
import 'package:blgym/train/train.dart';
import 'package:blgym/train/train_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrainFormPage extends StatefulWidget {
  final Train? train;

  const TrainFormPage({super.key, this.train});

  @override
  State<TrainFormPage> createState() => TrainFormPageState();
}

class TrainFormPageState extends State<TrainFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _formTrainName;
  final List<Exercise> _trainExercises = [];

  @override
  void initState() {
    super.initState();
    if (widget.train != null) {
      _formTrainName = widget.train!.name;
    } else {
      _formTrainName = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final exerciseController = Provider.of<ExerciseController>(context);
    final isEditing = widget.train != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Train' : 'Add Train'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                initialValue: _formTrainName,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a name'
                    : null,
                onSaved: (newValue) => _formTrainName = newValue!,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: exerciseController.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exerciseController.exercises[index];
                    return CheckboxListTile(
                      value: exercise.done,
                      onChanged: (newValue) {
                        setState(() {
                          newValue == true
                              ? _trainExercises.add(exercise)
                              : _trainExercises.remove(exercise);
                          exercise.done = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(exercise.name),
                      subtitle: Text(exercise.description!),
                      secondary: Text('${exercise.series} x ${exercise.cargo}'),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => _saveTrain(_trainExercises),
                child: Text(isEditing ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTrain(List<Exercise> trainExercises) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Train train = Train(
        id: widget.train?.id,
        name: _formTrainName,
        exercises: trainExercises,
      );
      final trainController =
          Provider.of<TrainController>(context, listen: false);
      if (widget.train == null) {
        trainController.addTrain(train);
      } else {
        trainController.updateTrain(train);
      }
      Navigator.pop(context);
    }
  }
}
