// lib/controllers/train_controller.dart
import 'package:flutter/material.dart';
import 'train.dart';
import 'train_service.dart';

class TrainController with ChangeNotifier {
  final TrainService _trainService = TrainService();
  List<Train> _trains = [];

  List<Train> get trains => _trains;

  TrainController() {
    fetchTrains();
  }

  Future<void> fetchTrains() async {
    _trains = await _trainService.getAllTrains();
    notifyListeners();
  }

  Future<void> addTrain(Train train) async {
    await _trainService.addTrain(train);
    await fetchTrains();
  }

  Future<void> updateTrain(Train train) async {
    await _trainService.updateTrain(train);
    await fetchTrains();
  }

  Future<void> deleteTrain(int id) async {
    await _trainService.deleteTrain(id);
    await fetchTrains();
  }
}
