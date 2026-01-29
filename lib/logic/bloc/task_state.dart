part of 'task_bloc.dart';

@immutable
sealed class TaskState extends Equatable {
  final List<TaskModel> taskList;

  const TaskState(this.taskList);

  @override
  List<Object?> get props => [taskList];

}

final class InitTask extends TaskState {
  InitTask() : super([]);


}

final class UpdateTask extends TaskState {
  const UpdateTask(super.tasks);
}
