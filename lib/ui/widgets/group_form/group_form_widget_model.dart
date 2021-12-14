
import 'package:flutter/cupertino.dart';
import 'package:todo_with_hive/domain/data_provider/box_manager.dart';
import 'package:todo_with_hive/domain/entity/group.dart';

class GroupFormWidgetModel {
  var groupName = '';

  void saveGroup(BuildContext context) async{
    if(groupName.isEmpty) return;
    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: groupName);
    await box.add(group);
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}

class GroupFormWidgetModelProvider extends InheritedWidget {
  final GroupFormWidgetModel model;

  const GroupFormWidgetModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, child: child);

  static GroupFormWidgetModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvider>();
  }

  static GroupFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormWidgetModelProvider>()
        ?.widget;
    return widget is GroupFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(GroupFormWidgetModelProvider old) {
    return false;
  }
}