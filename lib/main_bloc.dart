import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_with_cubit_or_bloc/logic/task_cubit.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('To Do App')),
        body: BlocProvider(
            create:(context) => TaskCubit(),
          child: BlocBuilder<TaskCubit,TaskState>(builder: (context,state){
            return Container();
          }),
        ),
      ),
    );
  }
}
