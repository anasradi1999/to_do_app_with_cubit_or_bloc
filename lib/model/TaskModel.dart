import 'package:equatable/equatable.dart';

class TaskModel extends Equatable{
  final String id;
  final String title;
  final bool isDone;

  const TaskModel({
    required this.id,
    required this.title,
    required this.isDone,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,

    );
  }
  @override
  List<Object?> get props => [id, title, isDone];


  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isDone': isDone,
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
    );
  }
}




