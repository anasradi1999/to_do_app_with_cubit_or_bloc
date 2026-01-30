import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/task_cubit.dart';
import 'add_todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Notes'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.taskList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.taskList[index].title),
                    subtitle: Text(
                      state.taskList[index].descriptions,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: state.taskList[index].isDone,
                          onChanged: (value) {
                            context.read<TaskCubit>().checkTask(
                              state.taskList[index].id,
                            );
                          },
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'Edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddTodo(task: state.taskList[index]),
                                ),
                              );

                            }else if (value == 'Delete') {
                              context.read<TaskCubit>().removeTask(
                                  state.taskList[index].id);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'Edit',
                              child: Row(
                                children: [
                                  Icon(
                                     Icons.edit,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Edit', style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Delete',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
