import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_with_hive/domain/entity/group.dart';
import 'package:todo_with_hive/domain/entity/task.dart';

class TasksWidgetModel extends ChangeNotifier{
  int groupKey;
  late final Future<Box<Group>> _groupBox;
  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  Group? _group;
  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}){
    _setup();
  }

  void showForm(BuildContext context){
    Navigator.of(context).pushNamed('/groups/tasks/form', arguments: groupKey);
  }

  void _loadGroup() async{
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks(){
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setupListenTasks() async{
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: <dynamic>[groupKey]).addListener(_readTasks);
  }

  void deleteTask(int taskIndex) async{
    await _group?.tasks?.deleteFromHive(taskIndex);
    await _group?.save();
  }

  void doneToggle(int taskIndex) async{
    final task = _group?.tasks?[taskIndex];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();

  }

  void _setup() {
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('groups_box');
    if(!Hive.isAdapterRegistered(2)){      // open, register, save
      Hive.registerAdapter(TaskAdapter());
    }
    Hive.openBox<Task>('tasks_box');
    _loadGroup();
    _setupListenTasks();
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;

  const TasksWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
      key: key,
      notifier: model,       // DO NOT FORGET
      child: child
  );

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget =  context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}