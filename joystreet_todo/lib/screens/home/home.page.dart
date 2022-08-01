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
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border.all(width: 3),
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(32), right: Radius.zero),
                ),
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'Bem Vindo(a)! ',
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.yellow,
                        fontStyle: FontStyle.italic,
                        fontFamily: '.SF UI Display',
                      ),
                    ),
                    TextSpan(
                      text: 'Esta é minha lista de tarefas. ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Clique em ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'adicionar ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'para criar uma nova tarefa',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ]),
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
                        semanticLabel: 'Icone do android',
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
                        splashColor: Colors.amberAccent,
                        onTap: () async {
                          await _onItemTouch(item);
                        },
                        child: Hero(
                          tag: 'tag-${item.descricao}',
                          child: ListTile(
                            title: Text(item.descricao),
                            tileColor: Colors.grey,
                          ),
                        ),
                      );
                    }
                    return InkWell(
                      splashColor: Colors.amberAccent,
                      onTap: () async {
                        await _onItemTouch(item);
                      },
                      child: ListTile(
                        title: Hero(
                          tag: 'tag-${item.descricao}',
                          child: Text(
                            item.descricao,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              InkWell(
                splashColor: Colors.yellowAccent,
                onTap: () async {
                  var novaTarefa = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return ScaleTransition(
                          alignment: Alignment.center,
                          scale: Tween<double>(begin: 0.1, end: 1).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.bounceIn,
                            ),
                          ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(seconds: 2),
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return const NewTaskPage();
                      },
                    ),
                  );
                  setState(() {
                    taskList.add(novaTarefa);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                      colors: [Colors.grey, Colors.amberAccent],
                    ),
                  ),
                  child: Text(
                    'ADICIONAR',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uma tarefa foi excluida'),
        ),
      );
      return;
    }

    setState(() {
      var index = taskList.indexWhere((element) => element == item);
      taskList[index] = tarefaAtualizada;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Uma tarefa foi alterada'),
      ),
    );
  }
}
