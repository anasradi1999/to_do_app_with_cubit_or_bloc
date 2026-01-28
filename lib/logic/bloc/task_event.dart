part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;

  AddTaskEvent(this.title);

}

class RemoveTaskEvent extends TaskEvent {
  final String id;
  RemoveTaskEvent(this.id);
}

class CheckTaskEvent extends TaskEvent {
  final String id;
  CheckTaskEvent(this.id);
}