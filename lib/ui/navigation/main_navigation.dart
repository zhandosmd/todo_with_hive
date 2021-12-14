import 'package:flutter/material.dart';

import 'package:todo_with_hive/ui/widgets/group_form/group_form_widget.dart';
import 'package:todo_with_hive/ui/widgets/groups/groups_widget.dart';
import 'package:todo_with_hive/ui/widgets/task_form/task_form_widget.dart';
import 'package:todo_with_hive/ui/widgets/tasks/tasks_widget.dart';

abstract class MainNavigationRouteNames{
  static const groups = '/';
  static const groupsForm = '/groupForm';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form';
}
class MainNavigation{
  final initialRoute = MainNavigationRouteNames.groups;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
    MainNavigationRouteNames.groupsForm: (context) => const GroupFormWidget(),
  };

  Route<Object>? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case MainNavigationRouteNames.tasks:
        final configuration = settings.arguments as TasksWidgetConfiguration;
        return MaterialPageRoute(
          builder: (context)=>TasksWidget(configuration: configuration,)
        );
      case MainNavigationRouteNames.tasksForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context)=>TaskFormWidget(groupKey: groupKey,)
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context)=>widget);
    }
  }
}