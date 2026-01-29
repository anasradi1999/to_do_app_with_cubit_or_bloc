import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../model/TaskModel.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(InitTask()) {
    on<AddTaskEvent>((event, emit) {
      final taskModel = TaskModel(
        id: Uuid().v4(),
        title: event.title,
        isDone: false,
      );
      emit(UpdateTask([...state.taskList, taskModel]));
    });

    on<RemoveTaskEvent>((event, emit) {
      emit(UpdateTask(state.taskList
          .where((task) => task.id != event.id)
          .toList()));
    });

    on<CheckTaskEvent>((event, emit) {
      final List<TaskModel> newList = state.taskList.map((task) {
        return task.id == event.id ? task.copyWith(isDone: !task.isDone) : task;
      }).toList();
      emit(UpdateTask(newList));
    });

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

