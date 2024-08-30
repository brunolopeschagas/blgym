// lib/views/exercise_form_view.dart
import 'package:blgym/exercise/exercise_controller.dart';
import 'package:blgym/exercise/exercise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseFormPage extends StatefulWidget {
  final Exercise? exercise;

  const ExerciseFormPage({super.key, this.exercise});

  @override
  State<ExerciseFormPage> createState() => _ExerciseFormPageState();
}

class _ExerciseFormPageState extends State<ExerciseFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  String? _description;
  int? _cargo;
  int? _series;

  @override
  void initState() {
    super.initState();
    if (widget.exercise != null) {
      _name = widget.exercise!.name;
      _description = widget.exercise!.description;
      _cargo = widget.exercise!.cargo;
      _series = widget.exercise!.series;
    } else {
      _name = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.exercise != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Exercise' : 'Add Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a name.'
                    : null,
                onSaved: (value) => _name = value!,
              ),
              // Description
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
              ),
              // Cargo
              TextFormField(
                initialValue: _cargo?.toString(),
                decoration: const InputDecoration(labelText: 'Cargo'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _cargo = value != null ? int.tryParse(value) : null,
              ),
              // Series
              TextFormField(
                initialValue: _series?.toString(),
                decoration: const InputDecoration(labelText: 'Series'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _series = value != null ? int.tryParse(value) : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveExercise,
                child: Text(isEditing ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveExercise() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final exercise = Exercise(
        id: widget.exercise?.id,
        name: _name,
        description: _description,
        cargo: _cargo,
        series: _series,
      );
      final exerciseController =
          Provider.of<ExerciseController>(context, listen: false);
      if (widget.exercise == null) {
        exerciseController.addExercise(exercise);
      } else {
        exerciseController.updateExercise(exercise);
      }
      Navigator.pop(context);
    }
  }
}
