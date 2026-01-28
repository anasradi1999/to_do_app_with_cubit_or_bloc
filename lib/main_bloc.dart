import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_with_cubit_or_bloc/logic/bloc/task_bloc.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
   MyApp({super.key});
  TextEditingController titleController = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('To Do App')),
        body: BlocProvider(
            create:(context) => TaskBloc(),
          child: BlocBuilder<TaskBloc,TaskState>(builder: (context,state){
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Task',
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isEmpty) return;
                        context.read<TaskBloc>().add(
                          AddTaskEvent(titleController.text,)
                        );
                        titleController.clear();
                      },
                      child: Text('Add Task'),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.taskList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.taskList[index].title),
                            leading: Checkbox(
                              value: state.taskList[index].isDone,
                              onChanged: (value) {
                                context.read<TaskBloc>().add(
                                  CheckTaskEvent(state.taskList[index].id),
                                );
                              },
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<TaskBloc>().add(
                                  RemoveTaskEvent(state.taskList[index].id),
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
