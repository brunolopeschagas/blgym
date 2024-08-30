// lib/models/exercise.dart
class Exercise {
  final int? id;
  final String name;
  final String? description;
  final int? cargo;
  final int? series;
  bool? done;

  Exercise(
      {this.id,
      required this.name,
      this.description,
      this.cargo,
      this.series,
      this.done = false});

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        cargo: json['cargo'],
        series: json['series'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'cargo': cargo,
        'series': series,
      };
}
