import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_with_cubit_or_bloc/screen/todo_list.dart';

import '../logic/cubit/task_cubit.dart';
import '../model/TaskModel.dart';

class AddTodo extends StatefulWidget {
  final TaskModel? task;
  const AddTodo({super.key, this.task});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late bool isDone;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task?.title ?? '');
    descriptionController = TextEditingController(text: widget.task?.descriptions ?? '');
    isDone = widget.task?.isDone ?? false;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Note' : 'Edit Task')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      decoration:
                      const InputDecoration(hintText: 'Enter Title'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Switch(
                    value: isDone,
                    onChanged: (value) {
                      setState(() {
                        isDone = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration:
                const InputDecoration(hintText: 'Enter Descriptions'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    if (widget.task == null) {
                      context.read<TaskCubit>().addTask(
                        titleController.text,
                        descriptionController.text,
                        isDone,
                      );
                    } else {
                      final updatedTask = widget.task!.copyWith(
                        title: titleController.text,
                        descriptions: descriptionController.text,
                        isDone: isDone,
                      );
                      context.read<TaskCubit>().editTask(updatedTask);
                    }
                    Navigator.pop(context);

                  },
                  child: Text(
                    widget.task == null ? 'Add Note' : 'Save Changes',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
