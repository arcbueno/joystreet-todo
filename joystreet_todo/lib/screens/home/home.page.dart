import 'package:flutter/material.dart';
import 'package:joystreet_todo/model/task.dart';
import 'package:joystreet_todo/screens/detail/task_detail.page.dart';
import 'package:joystreet_todo/screens/new/new_task.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final taskList = <Task>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My To Do List"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Bem Vindo! Toque no botão abaixo para criar uma nova tarefa',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black.withOpacity(.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            if (taskList.isEmpty)
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nenhum item inserido',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Icon(
                      Icons.android,
                      size: 128,
                    ),
                  ],
                ),
              )
            else
              ListView.separated(
                itemCount: taskList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = taskList[index];
                  if (item.concluido) {
                    return InkWell(
                      onTap: () async {
                        await _onItemTouch(item);
                      },
                      child: ListTile(
                        title: Text(item.descricao),
                        tileColor: Colors.grey,
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () async {
                      await _onItemTouch(item);
                    },
                    child: ListTile(
                      title: Text(item.descricao),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var novaTarefa = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const NewTaskPage()),
            ),
          );
          setState(() {
            taskList.add(novaTarefa);
          });
        },
        tooltip: 'New',
        child: const Icon(Icons.add),
      ),
    );
  }

  _onItemTouch(Task item) async {
    var tarefaAtualizada = await Navigator.of(context).push(MaterialPageRoute(
      builder: ((context) => TaskDetailPage(item: item)),
    ));
    if (tarefaAtualizada == null) {
      setState(() {
        taskList.remove(item);
      });
      return;
    }

    setState(() {
      var index = taskList.indexWhere((element) => element == item);
      taskList[index] = tarefaAtualizada;
    });
  }
}
