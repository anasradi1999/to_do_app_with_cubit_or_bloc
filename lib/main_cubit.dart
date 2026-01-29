import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_app_with_cubit_or_bloc/logic/cubit/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // بنينا التخزين persisted storage
  HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );

  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'To Do App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: BlocProvider(
          create: (context) => TaskCubit(),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
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
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isEmpty) return;
                          context.read<TaskCubit>().addTask(
                            titleController.text,
                          );
                          titleController.clear();
                        },
                        child: const Text('Add Task'),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.taskList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.taskList[index].title),
                              leading: Checkbox(
                                value: state.taskList[index].isDone,
                                onChanged: (value) {
                                  context.read<TaskCubit>().checkTask(
                                    state.taskList[index].id,
                                  );
                                },
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  context.read<TaskCubit>().removeTask(
                                    state.taskList[index].id,
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
