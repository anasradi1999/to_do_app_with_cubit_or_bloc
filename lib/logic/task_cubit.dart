import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../model/TaskModel.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(InitTask());

  void addTask(String title) {
    final taskModel = TaskModel(
      id: Uuid().v4(),
      title: title,
      isDone: false,
    );
    emit(UpdateTake([...state.taskList, taskModel]));
  }

  void removeTask(String id) {
    emit(UpdateTake(state.taskList
        .where((task) => task.id != id)
        .toList()));
  }

  void checkTask(String id) {
    final List<TaskModel> newList = state.taskList.map((task) {
      return task.id == id ? task.copyWith(isDone: !task.isDone) : task;
    }).toList();
    emit(UpdateTake(newList));
    }
}
