import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_app_with_cubit_or_bloc/logic/cubit/task_cubit.dart';
import 'package:to_do_app_with_cubit_or_bloc/screen/add_todo.dart';
import 'package:to_do_app_with_cubit_or_bloc/screen/todo_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // بنينا التخزين persisted storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
        (await getApplicationDocumentsDirectory()).path),
  );

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TodoList(),
      ),
    );
  }
}
