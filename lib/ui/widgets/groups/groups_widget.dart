import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_with_hive/ui/widgets/groups/groups_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
      model: _model,
      child: const _GroupWidgetBody()
    );
  }

  @override
  void dispose() async {
    await _model.dispose();
    super.dispose();
  }
}

class _GroupWidgetBody extends StatelessWidget {
  const _GroupWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Группы'),
        elevation: 0,
        centerTitle: true,
      ),
      body: const _GroupListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GroupsWidgetModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount = GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: groupsCount,
      itemBuilder: (context, index){
        return _GroupListRowWidget(indexInList: index);
      },
      separatorBuilder: (context, index){
        return const Divider(height: 3,);
      },
    );
  }
}


class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({Key? key, required this.indexInList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = model.groups[indexInList];
    return Slidable(
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          // title: const Text('Some text'),
          title: Text(group.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: ()=>model.showTasks(context, indexInList),
        ),
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) => model.delete(indexInList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
    );
  }
}
