import 'package:flutter/material.dart';
import 'package:todo_with_hive/widgets/group_form/group_form_widget.dart';
import 'package:todo_with_hive/widgets/groups/groups_widget.dart';
import 'package:todo_with_hive/widgets/task_form/task_form_widget.dart';
import 'package:todo_with_hive/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/groups',
      routes: {
        '/groups': (context) => const GroupsWidget(),
        '/groups/form': (context) => const GroupFormWidget(),
        '/groups/tasks': (context) => const TasksWidget(),
        '/groups/tasks/form': (context) => const TaskFormWidget(),
      },
    );
  }
}
