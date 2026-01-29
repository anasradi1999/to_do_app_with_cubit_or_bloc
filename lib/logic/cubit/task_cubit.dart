import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../model/TaskModel.dart';

part 'tasks_state.dart';

class TaskCubit extends HydratedCubit<TaskState> {
  TaskCubit() : super(InitTask());

  void addTask(String title) {
    final taskModel = TaskModel(id: Uuid().v4(), title: title, isDone: false);
    emit(UpdateTask([...state.taskList, taskModel]));
  }

  void removeTask(String id) {
    emit(UpdateTask(state.taskList.where((task) => task.id != id).toList()));
  }

  void checkTask(String id) {
    final List<TaskModel> newList = state.taskList.map((task) {
      return task.id == id ? task.copyWith(isDone: !task.isDone) : task;
    }).toList();
    emit(UpdateTask(newList));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    final list = (json['todolist'] as List)
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return UpdateTask(list);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return {
      'todolist': state.taskList
          .map((todo) => todo.toJson())
          .toList(growable: false),
    };
  }
}
