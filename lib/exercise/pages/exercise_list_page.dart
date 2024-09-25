// lib/views/exercise_list_view.dart
import 'package:blgym/exercise/exercise_controller.dart';
import 'package:blgym/exercise/exercise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exercise_form_page.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key});

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  @override
  void initState() {
    super.initState();
    final exerciseController = context.read<ExerciseController>();
    exerciseController.fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    final exerciseController = Provider.of<ExerciseController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: ListView.builder(
        itemCount: exerciseController.exercises.length,
        itemBuilder: (context, index) {
          final exercise = exerciseController.exercises[index];
          return ListTile(
            title: Text(exercise.name),
            subtitle: Text(exercise.description ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _navigateToEditExercise(context, exercise),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      exerciseController.deleteExercise(exercise.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddExercise(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddExercise(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExerciseFormPage()),
    );
  }

  void _navigateToEditExercise(BuildContext context, Exercise exercise) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseFormPage(exercise: exercise)),
    );
  }
}
