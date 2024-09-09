import 'dart:io';
import 'package:blgym/exercise/exercise_controller.dart';
import 'package:blgym/shared/page/home_page.dart';
import 'package:blgym/train/train_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const ExerciseRoutineManagerApp());
}

class ExerciseRoutineManagerApp extends StatelessWidget {
  const ExerciseRoutineManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExerciseController>(
          create: (_) => ExerciseController(),
        ),
        ChangeNotifierProvider<TrainController>(
          create: (_) => TrainController(),
        ),
      ],
      child: MaterialApp(
        title: 'Exercise Routine Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
